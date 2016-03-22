class Cylinder{

static final float cylinderBaseSize = 10;
static final float cylinderHeight = 10;
static final int cylinderResolution = 8;
PShape openCylinder;
PShape closeBottom;
PShape closeUp;


Cylinder(){
  openCylinder = new PShape();
  closeBottom = new PShape();
  closeUp = new PShape();
  
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

void display(float x, float y, float z){
  pushMatrix();
  rotateX(PI/2);
  translate(x-width/2, y- cylinderHeight/2f, z-height/2 );
  shape(openCylinder);
  shape(closeBottom);
  shape(closeUp);
  popMatrix();
}


}