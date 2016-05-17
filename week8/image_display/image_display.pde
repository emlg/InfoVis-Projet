import processing.video.*;
import java.util.*;

Capture cam;
PImage img, result;
HScrollBar hueBar1, hueBar2;

float discretizationStepsPhi;
float discretizationStepsR;
int phiDim;
float[] tabSin;
float[] tabCos;
float ang;
float inverseR;

void settings() {
  size(800, 600);
  //size(640, 480);
}

void setup() {
  hueBar1 = new HScrollBar(0, 580, 800, 20);
  hueBar2 = new HScrollBar(0, 560, 800, 20);
  img = loadImage("board3.jpg");
  result = createImage(width, height, RGB);

  /*String[] cameras = Capture.list();
   if (cameras.length == 0) {
   println("There are no cameras available for capture.");
   exit();
   } else {
   println("Available cameras:");
   for (int i = 0; i < cameras.length; i++) {
   println(cameras[i]);
   }
   cam = new Capture(this, cameras[0]);
   cam.start();
   }*/
   discretizationStepsPhi = 0.06f;
discretizationStepsR = 2.5f;

// dimensions of the accumulator
 phiDim = (int) (Math.PI / discretizationStepsPhi);
// pre-compute the sin and cos values
tabSin = new float[phiDim];
tabCos = new float[phiDim];
ang = 0;
inverseR = 1.f / discretizationStepsR;

for (int accPhi = 0; accPhi < phiDim; ang += discretizationStepsPhi, accPhi++) {
  // we can also pre-multiply by (1/discretizationStepsR) since we need it in the Hough loop
  tabSin[accPhi] = (float) (Math.sin(ang) * inverseR);
  tabCos[accPhi] = (float) (Math.cos(ang) * inverseR);
}

}

void draw() {
  /*Display of the 1st part : trying masks on the image
   
   background(color(0,0,0));
   float i = hueBar1.getPos(), j = hueBar2.getPos();
   hueMap(result, min(i, j), max(i, j));
   image(result, 0, 0);
   hueBar1.display(); hueBar1.update();
   hueBar2.display(); hueBar2.update();*/

  result = saturationMap(brightnessMap(hueMap(img, 0.2, 0.8), 0, 0.5), 0, 0.5);
  image(result, 0, 0);
  result = sobel(convolute(binary(result, 15.f)));
  
  List<PVector> lines = hough(result, 6);
  List<int[]> quads = filterQuads(lines);

  //List<PVector> inter = getIntersections(lines);
  for (int[] quad : quads) {
    PVector l1 = lines.get(quad[0]);
    PVector l2 = lines.get(quad[1]);
    PVector l3 = lines.get(quad[2]);
    PVector l4 = lines.get(quad[3]);

    PVector c12 = getIntersection(l1, l2);
    PVector c23 = getIntersection(l2, l3);
    PVector c34 = getIntersection(l3, l4);
    PVector c41 = getIntersection(l4, l1);
    // Choose a random, semi-transparent colour
    Random random = new Random();
    fill(color(min(255, random.nextInt(300)), 
      min(255, random.nextInt(300)), 
      min(255, random.nextInt(300)), 50));
    quad(c12.x, c12.y, c23.x, c23.y, c34.x, c34.y, c41.x, c41.y);
  }

  /*if (cam.available())
   cam.read();
   img = cam.get();
   result = sobel(convolute(binary(img, 15.f)));
   image(result, 0, 0);
   hough(result);*/
}