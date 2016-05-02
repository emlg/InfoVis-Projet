/*import processing.video.*;
Capture cam;*/
PImage img;

PImage result;
HScrollBar hueBar1, hueBar2;

void settings() {
  size(800, 600);
  //size(640, 480);
}

void setup() {
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
  hueBar1 = new HScrollBar(0, 580, 800, 20);
  hueBar2 = new HScrollBar(0, 560, 800, 20);
  img = loadImage("board1.jpg");
  result = createImage(width, height, RGB);
}

void draw() {
  /*background(color(0,0,0));
   float i = hueBar1.getPos(), j = hueBar2.getPos();
   hueMap(result, min(i, j), max(i, j));
   image(result, 0, 0);
   hueBar1.display(); hueBar1.update();
   hueBar2.display(); hueBar2.update();*/
  /*if (cam.available() == true) {
    cam.read();
  }
  img = cam.get();
  image(img, 0, 0);*/
  hueMap(result,  0.4615385, 0.5307692);
  result = sobel(convolute(binary(result, 15.f)));
  image(result, 0, 0);
  hough(result);
}