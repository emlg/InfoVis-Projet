// definition of the table constants
float discretizationStepsPhi = 0.06f;
float discretizationStepsR = 2.5f;
int phiDim = (int) (Math.PI / discretizationStepsPhi);

class HoughComparator implements java.util.Comparator<Integer> {
  int[] accumulator;

  public HoughComparator(int[] accumulator) {
    this.accumulator = accumulator;
  }

  @Override
    public int compare(Integer l1, Integer l2) {
    if (accumulator[l1] > accumulator[l2]
      || (accumulator[l1] == accumulator[l2] && l1 < l2)) return -1;
    return 1;
  }
}

ArrayList<PVector> hough(PImage edgeImg, int nLines) {
  ArrayList<Integer> bestCandidates = new ArrayList<Integer>();
  ArrayList<PVector> detectedLines = new ArrayList<PVector>();

  // dimensions of the accumulator
  int rDim = (int) (((edgeImg.width + edgeImg.height) * 2 + 1) / discretizationStepsR);
  int[] accumulator = new int[(phiDim + 2) * (rDim + 2)];

  // definition of line candidates
  for (int y = 0; y < edgeImg.height; y++)
    for (int x = 0; x < edgeImg.width; x++)
      if (brightness(edgeImg.pixels[y * edgeImg.width + x]) != 0) {
       for (int phi = 0; phi < phiDim; phi++) {
          float r = x * cos(phi*discretizationStepsPhi) + y * sin(phi*discretizationStepsPhi);
          r = r/discretizationStepsR + (rDim - 1)/2; 
          accumulator[round((phi+1)*(rDim+2) + r +1)] += 1;
        }

      }


  // choosing only the best candidates
  houghImg = createImage(rDim + 2, phiDim + 2, ALPHA);
  for (int i = 0; i < accumulator.length; i++) {
    houghImg.pixels[i] = color(min(255, accumulator[i]));
  }

  // size of the region we search for a local maximum
  int neighbourhood = 30;
  // only search around lines with more that this amount of votes
  int minVotes = 200;
  for (int accR = 0; accR < rDim; accR++) {
    for (int accPhi = 0; accPhi < phiDim; accPhi++) {
      // compute current index in the accumulator
      int idx = (accPhi + 1) * (rDim + 2) + accR + 1;
      if (accumulator[idx] > minVotes) {
        boolean bestCandidate=true;
        // iterate over the neighbourhood
        for (int dPhi=-neighbourhood/2; dPhi < neighbourhood/2+1; dPhi++) {
          // check we are not outside the image
          if (accPhi+dPhi < 0 || accPhi+dPhi >= phiDim) continue;
          for (int dR=-neighbourhood/2; dR < neighbourhood/2 +1; dR++) {
            // check we are not outside the image
            if (accR+dR < 0 || accR+dR >= rDim) continue;
            int neighbourIdx = (accPhi + dPhi + 1) * (rDim + 2) + accR + dR + 1;
            if (accumulator[idx] < accumulator[neighbourIdx]) {
              // the current idx is not a local maximum!
              bestCandidate=false;
              break;
            }
          }
          if (!bestCandidate) break;
        }
        if (bestCandidate) {
          // the current idx *is* a local maximum
          bestCandidates.add(idx);
        }
      }
    }
  }

  Collections.sort(bestCandidates, new HoughComparator(accumulator));
  // You may want to resize the accumulator to make it easier to see:
  houghImg.resize(400, 400);
  houghImg.updatePixels();


  // plotting the lines on the picture
  for (int idx = 0; idx < min(nLines, bestCandidates.size()); idx++) {
    int accPhi = (int) (bestCandidates.get(idx) / (rDim + 2)) - 1;
    int accR = bestCandidates.get(idx) - (accPhi + 1) * (rDim + 2) - 1;
    float r = (accR - (rDim - 1) * 0.5f) * discretizationStepsR;
    float phi = accPhi * discretizationStepsPhi;

    detectedLines.add(new PVector(r, phi));

    int x0 = 0, y0 = (int) (r / sin(phi));
    int x1 = (int) (r / cos(phi)), y1 = 0;
    int x2 = edgeImg.width, y2 = (int) (-cos(phi) / sin(phi) * x2 + r / sin(phi));
    int y3 = edgeImg.width, x3 = (int) (-(y3 - r / sin(phi)) * (sin(phi) / cos(phi)));

    stroke(204, 102, 0);
    if (y0 > 0) {
      if (x1 > 0)
        line(x0, y0, x1, y1);
      else if (y2 > 0)
        line(x0, y0, x2, y2);
      else
        line(x0, y0, x3, y3);
    } else {
      if (x1 > 0) {
        if (y2 > 0)
          line(x1, y1, x2, y2);
        else
          line(x1, y1, x3, y3);
      } else
        line(x2, y2, x3, y3);
    }
  }
  return detectedLines;
}