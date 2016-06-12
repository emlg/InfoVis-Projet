import processing.video.*;
import java.util.*;

Boolean isPaused = false;
  Movie cam;
class ImageProcessing extends PApplet {

  PImage img;


  float[] tabSin;
  float[] tabCos;
  float ang;
  float inverseR;

  List<PVector> corners;
  TwoDThreeD converter;
  PVector angles;

  public void mouseClicked() {
    if (!isPaused) {
      isPaused = true;
    } else {
      isPaused = false;
    }
  }

  void settings() {
    size(640, 480);
  }

  void setup() {
    cam = new Movie(this, "/Users/emma/Cours/Sem4/Informatique visuelle/InfoVis-Projet/Game/testVideo.mp4");
    cam.loop();
    //img = loadImage("/Users/emma/Cours/Sem4/Informatique visuelle/InfoVis-Projet/Game/data/board1.jpg");
    angles = new PVector(0, 0, 1);
  }

  public void stop() {
    cam.stop();
    cam = null;
    super.stop();
    System.exit(0);
  }

  void draw() {

    if (cam.available()) {
      cam.read();
      img = cam.get();

      if (img == null) {
        return;
      }
    } else {
      return;
    }
  
      image(img, 0, 0);

      img = saturationMap(brightnessMap(hueMap(img, 50, 130), 5, 180), 120, 255);
      img = convolute(img);
      img = brightnessMap(img, 100, 255);
      img = sobel(img);
      List<PVector> lines = hough(img, 5);

      QuadGraph quadGraph = new QuadGraph();
      quadGraph.build(lines, img.width, img.height);
      List<int[]> quads = quadGraph.findCycles();
      float min_area = img.width * img.height / 10;
      float max_area = img.width * img.height * 9/10;

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

      double dist = Double.MAX_VALUE;
      double newDist = 0;
      double[][] imgCorners = {{0, 0}, {img.width, 0}, {img.width, img.height}, {0, img.height}};

      List<PVector> output = new ArrayList<PVector>();
      for (int j = 0; j < imgCorners.length; j++) {
        output.add(corners[j]);
        for (int i = 0; i < corners.length; i++) {
          newDist = Math.sqrt(Math.pow(corners[i].x - imgCorners[j][0], 2) + Math.pow(corners[i].y - imgCorners[j][1], 2));
          if (newDist < dist) {
            dist = newDist;
            output.set(j, corners[i]);
          }
        }
        newDist = 0;
        dist = Double.MAX_VALUE;
      }

      quad(output.get(0).x, output.get(0).y, output.get(1).x, output.get(1).y, output.get(2).x, output.get(2).y, output.get(3).x, output.get(3).y);

      converter = new TwoDThreeD(img.width, img.height);
      angles = converter.get3DRotations(output);
      //println("rx : " + degrees(angles.x) + " ry : "+ degrees(angles.y) + " rz : " + degrees(angles.z));
    
  }

  PVector getRotation() {
    return angles;
  }
}