/*import processing.video.*;
Capture cam;*/
PImage img;

PImage result;
ArrayList<PVector> lines;
ArrayList<PVector> corners;
HScrollBar hueBar1, hueBar2;

void settings() {
  size(800, 600);
  /*println("Hello");
  size(320, 240);*/
}

void setup() {
    
  /*cam = new Capture(this, "FaceTime HD Camera");
  cam.start();*/
  /*String[] cameras = Capture.list();
  println(cameras[0]);
  if (cameras.length == 0) {
    println("There are no cameras available for capture.");
    exit();
  } else {
    println("Available cameras:");
    for (int i = 0; i < cameras.length; i++) {
      println(cameras[i]);
    }
    
    
  }*/
  hueBar1 = new HScrollBar(0, 580, 800, 20);
  hueBar2 = new HScrollBar(0, 560, 800, 20);
  img = loadImage("board4.jpg");
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
  }*/
  //img = cam.get();
  //image(cam, 0, 0);
  result = brightnessMap(img, 0.2, 0.6);
  result = saturationMap(result, 0.5, 1);
  result = hueMap(result,  0.46, 0.53);
  
  //image(result, 0 , 0);
  
  result = sobel(convolute(binary(result, 15.f)));
  image(img, 0, 0);
  lines = hough(result, 4);
  corners = getIntersections(lines);
}