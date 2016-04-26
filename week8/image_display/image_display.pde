PImage img, result;
HScrollBar hueBar1, hueBar2;

void settings(){
  size(800, 600);
}

void setup(){
  hueBar1 = new HScrollBar(0, 580, 800, 20);
  hueBar2 = new HScrollBar(0, 560, 800, 20);
  img = loadImage("board1.jpg");
  //result = createImage(width, height, RGB);
  result = createImage(img.width, img.height, ALPHA);
}

void draw(){
  /*background(color(0,0,0));
  float i = hueBar1.getPos(), j = hueBar2.getPos();
  hueMap(result, min(i, j), max(i, j));
  image(result, 0, 0);
  hueBar1.display(); hueBar1.update();
  hueBar2.display(); hueBar2.update();*/
  
  convolute(img, result);
  image(result, 0, 0);
}