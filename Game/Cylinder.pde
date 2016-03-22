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
    openCylinder.vertex(x[i], 0 , y[i]);
    openCylinder.vertex(x[i], cylinderHeight,y[i] );
  }
  openCylinder.endShape();
  
  closeBottom = createShape();
  closeBottom.beginShape(TRIANGLES);
  //close bottom of the cylinder
  for(int i = 0; i < x.length; i++){
    closeBottom.vertex(x[i], 0, y[i]);
    closeBottom.vertex(0,0, 0);
    closeBottom.vertex(x[(i+1)% x.length], 0, y[(i+1) % x.length]);
  }
  closeBottom.endShape();
  
  closeUp = createShape();
  closeUp.beginShape(TRIANGLES);
  //close the upper circle of cylinder
  for(int i = 0; i <x.length; i++){
    closeUp.vertex(x[i], cylinderHeight,y[i] );
    closeUp.vertex(0,cylinderHeight, 0);
    closeUp.vertex(x[(i+1)% x.length], cylinderHeight, y[(i+1) % x.length]);
  }
  closeUp.endShape();
}

void display(float x, float y, float z){
  pushMatrix();
  translate(x-width/2, y - cylinderHeight, z-height/2 );
  shape(openCylinder);
  shape(closeBottom);
  shape(closeUp);
  popMatrix();
}


}