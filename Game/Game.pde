void settings() {
  size(500, 500, P3D);
}
void setup() {
  noStroke();
}
float angleX = 0;
float angleZ = 0;
float valueX = 250;
float valueZ = 250;
float change = 1;

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
  angleX = map(valueX, 0, height, -PI/6, PI/6);
  angleZ = map(valueZ, 0 , width, -PI/6, PI/6);
  rotateX(PI/2);
  rotateX(angleX);
  rotateY(angleZ);
  box(100, 100, 10);

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