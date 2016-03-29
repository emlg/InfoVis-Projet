void settings() {
  size(500, 500, P3D);
}
//dimensions de la box
float boxX = 200;
float boxY = 10;
float boxZ = 200;

float valueX;
float valueZ;
float angleX = 0;
float angleZ = 0;
float change = 1;
Mover ball;
boolean shiftMode = false;
ArrayList<PVector> cylinders = new ArrayList<PVector>();

void setup() {
  noStroke();
  ball = new Mover();
  pushMatrix();
  translate(width/2, height/2, 0);
  valueX = width/2.0;
  valueZ = height/2.0;
  popMatrix();
}

void draw() {
  background(200);
  lights();
  translate(width/2, height/2, 0);
  fill(150);
 
  if(!shiftMode){
    pushMatrix();
    rotateX(angleX);
    rotateZ(angleZ);
    box(boxX, boxY, boxZ);   
    for(int i = 0; i < cylinders.size(); i++){
        fill(250, 160,25);
      Cylinder newCylinder = new Cylinder();
      newCylinder.display(cylinders.get(i).x -width/2, -boxY/2- Cylinder.cylinderHeight, cylinders.get(i).y - height/2);
    }
    pushMatrix();
    ball.update(angleZ, angleX);
    ball.checkEdges();
    ball.checkCylinderCollision();
    ball.display();
    popMatrix();
    popMatrix();
  } else {
    box(boxX, boxZ, boxY);
    for(int i = 0; i < cylinders.size(); i++){
      fill(250, 160,25);
      Cylinder newCylinder = new Cylinder();
      newCylinder.display(cylinders.get(i).x -width/2, cylinders.get(i).y - height/2, boxY/2);
    }
  }
  
}