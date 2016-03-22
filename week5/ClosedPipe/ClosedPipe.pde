float cylinderBaseSize = 50;
float cylinderHeight = 50;
int cylinderResolution = 40;
PShape openCylinder = new PShape();
PShape closeBottom = new PShape();
PShape closeUp = new PShape();

void settings() {
  size(400, 400, P3D);
}
void setup() {
  float angle;
  float[] x = new float[cylinderResolution + 1];
  float[] y = new float[cylinderResolution + 1];
  //get the x and y position on a circle for all the sides
  for(int i = 0; i < x.length; i++) {
    angle = (TWO_PI / cylinderResolution) * i;
    x[i] = sin(angle) * cylinderBaseSize;
    y[i] = cos(angle) * cylinderBaseSize;
  }
  openCylinder = createShape();
  openCylinder.beginShape(QUAD_STRIP);
  //draw the border of the cylinder
  for(int i = 0; i < x.length; i++) {
    openCylinder.vertex(x[i], y[i] , 0);
    openCylinder.vertex(x[i], y[i], cylinderHeight);
  }
  openCylinder.endShape();
  
  closeBottom = createShape();
  closeBottom.beginShape(TRIANGLES);
  //close bottom of the cylinder
  for(int i = 0; i < x.length; i++){
    closeBottom.vertex(x[i], y[i], 0);
    closeBottom.vertex(0,0, 0);
    closeBottom.vertex(x[(i+1)% x.length], y[(i+1) % x.length], 0);
  }
  closeBottom.endShape();
  
  closeUp = createShape();
  closeUp.beginShape(TRIANGLES);
  //close the upper circle of cylinder
  for(int i = 0; i <x.length; i++){
    closeUp.vertex(x[i], y[i], cylinderHeight);
    closeUp.vertex(0,0, cylinderHeight);
    closeUp.vertex(x[(i+1)% x.length], y[(i+1) % x.length], cylinderHeight);
  }
  closeUp.endShape();
}

void draw() {
  background(255);
  translate(mouseX, mouseY, 0);
  shape(openCylinder);
  shape(closeBottom);
  shape(closeUp);
}