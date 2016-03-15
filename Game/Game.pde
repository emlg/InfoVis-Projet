void settings() {
  size(500, 500, P3D);
}

float valueX;
float valueZ;
Mover ball;

void setup() {
  noStroke();
  ball = new Mover();
  pushMatrix();
  translate(width/2, height/2, 0);
  valueX = width/2.0;
  valueZ = height/2.0;
  popMatrix();
}


float angleX = 0;
float angleZ = 0;
float change = 1;
PVector bottomLeft;
PVector upRight;

void draw() {
  background(200);
  lights();
  translate(width/2, height/2, 0);
  fill(150);
  
  if(valueX < 0) {
    valueX =0;
  } else if (valueX > height) {
    valueX = height;
  } else if (valueZ <0){
    valueZ = 0;
  } else if (valueZ > width){
    valueZ = width;
  }
  angleX = map(valueX, 0, height, PI/6, -PI/6);
  angleZ = map(valueZ, 0 , width, -PI/6, PI/6);
  pushMatrix();
  rotateX(PI/2);
  rotateX(angleX);
  rotateY(angleZ);
  box(100, 100, 10);
  pushMatrix();
  ball.update(angleZ, angleX);
  ball.checkEdges();
  ball.display();
  popMatrix();
  popMatrix();
}


void mouseDragged(){
   valueZ += (mouseX- pmouseX) *change;
   valueX += (mouseY- pmouseY) *change;
}

void mouseWheel(MouseEvent event) {
  change += event.getCount();
  change = change*0.1;
  if(change > 1.5) {
     change = 1.5;
  } else if (change < 0.2){
    change = 0.2;
  }
  println(change);
}