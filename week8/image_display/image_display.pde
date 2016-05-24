import processing.video.*;
import java.util.*;

Capture cam;
PImage img, result;
PImage houghImg;
HScrollBar hueBar1, hueBar2;

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
  img = loadImage("board4.jpg");
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

    result = saturationMap(brightnessMap(hueMap(img, 96, 140), 38, 137), 116, 255);
  result = convolute(result);
  result = brightnessMap(result, 0, 153);
  result = sobel(result);
  List<PVector> lines = hough(result, 4);

  image(img, 0, 0);
 
  displayQuads(lines);
  getIntersections(lines);

  /*if (cam.available())
   cam.read();
   img = cam.get();
   result = sobel(convolute(binary(img, 15.f)));
   image(result, 0, 0);
   hough(result);*/
}