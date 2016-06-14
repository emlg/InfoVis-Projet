import processing.video.*;
import java.util.*;

Boolean isPaused = false;
Movie cam;
PImage vid;
PImage detect;
class ImageProcessing extends PApplet {

  float[] tabSin;
  float[] tabCos;
  float ang;
  float inverseR;

  List<PVector> corners;
  TwoDThreeD converter;
  PVector angles;

  void settings() {
  }

  void setupIP() {
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

  void computeAngles() {

    if (cam.available()) {
      cam.read();
      vid = cam.get();

      if (vid == null) {
        return;
      }
    } else {
      return;
    }
  
      image(vid, 0, 0);

      detect = saturationMap(brightnessMap(hueMap(vid, 50, 130), 50, 180), 120, 255);
      detect = convolute(detect);
      detect = brightnessMap(detect, 100, 255);
      detect = sobel(detect);
      List<PVector> lines = hough(detect, 5);

      QuadGraph quadGraph = new QuadGraph();
      quadGraph.build(lines, detect.width, detect.height);
      List<int[]> quads = quadGraph.findCycles();
      float min_area = detect.width *detect.height / 10;
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


      double[][] imgCorners = {{0, 0}, {detect.width, 0}, {detect.width, detect.height}, {0, detect.height}};

      List<PVector> output = new ArrayList<PVector>();
      for (int j = 0; j < imgCorners.length; j++) {
        output.add(corners[j]);
      }

      //quad(output.get(0).x, output.get(0).y, output.get(1).x, output.get(1).y, output.get(2).x, output.get(2).y, output.get(3).x, output.get(3).y);

      converter = new TwoDThreeD(detect.width, detect.height);
      angles = converter.get3DRotations(quadGraph.sortCorners(output));    
  }

  PVector getRotation() {
    computeAngles();
    return angles;
  }
}