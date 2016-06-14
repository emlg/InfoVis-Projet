import processing.video.*;
Movie cam;
PImage vid;
PImage detect;
List<PVector> corners;
TwoDThreeD converter;
PVector angles;


void setupCam() {
  cam = new Movie(this, "/Users/emma/Cours/Sem4/Informatique visuelle/InfoVis-Projet/Game/testVideo.mp4");
  cam.loop();
  angles = new PVector(0, 0, 1);
}


void computeAngles() {

  cam.read();
  vid = cam.get();

  detect = saturationMap(brightnessMap(hueMap(vid, 50, 130), 50, 180), 120, 255);
  detect = convolute(detect);
  detect = brightnessMap(detect, 100, 255);
  detect = sobel(detect);
  List<PVector> lines = hough(detect, 5);

  QuadGraph quadGraph = new QuadGraph();
  quadGraph.build(lines, detect.width, detect.height);
  List<int[]> quads = quadGraph.findCycles();
  float min_area = detect.width * detect.height / 10;
  float max_area = detect.width * detect.height * 9/10;

  PVector[] corners = new PVector[4];
  Boolean quadFound = false;

  for (int[] quad : quads) {
    PVector l1 = lines.get(quad[0]);
    PVector l2 = lines.get(quad[1]);
    PVector l3 = lines.get(quad[2]);
    PVector l4 = lines.get(quad[3]);

    PVector c12 = getIntersection(l1, l2);
    PVector c23 = getIntersection(l2, l3);
    PVector c34 = getIntersection(l3, l4);
    PVector c41 = getIntersection(l4, l1);
    float area = quadGraph.area(c12, c23, c34, c41);

    if ( area < max_area && area > min_area && quadGraph.isConvex(c12, c23, c34, c41)) {
      quadFound = true;
      min_area = area;

      corners[0] = c12;
      corners[1] = c23;
      corners[2] = c34;
      corners[3] = c41;
    }
  }

  if (!quadFound)
    return;

  List<PVector> output = new ArrayList<PVector>();
  for (int j = 0; j < corners.length; j++) {
    output.add(corners[j]);
  }

  converter = new TwoDThreeD(detect.width, detect.height);
  angles = converter.get3DRotations(quadGraph.sortCorners(output));
}