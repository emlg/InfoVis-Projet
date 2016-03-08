void settings() {
  size(500, 500, P3D);
}
void setup() {
  noStroke();
}
float angleX = 0;
float angleY = 0;
float angleZ = 0;
float change = 0;
float step = PI/8 + change;
void draw() {
  background(200);
  lights();
  translate(width/2, height/2, 0);
  fill(150);
  rotateX(angleX);
  rotateY(angleY);
  rotateZ(angleZ);
  box(100, 100, 10);

}

void keyPressed(){
  if(key == CODED){
    if(keyCode == LEFT){
      angleY += step;
    } else if (keyCode == RIGHT){
      angleY -= step;
    }
  }
}


void mouseDragged(){
  if(mouseX> pmouseX){
    if(angleX + step > PI/3){
      angleX = PI/3;
     } else {
      angleX = angleX + step;
      }
  } else if (mouseX < pmouseX){
    if(angleX - step < -PI/3){
      angleX = -PI/3;
      } else {
      angleX = angleX - step;
      }
  } else if (mouseY > pmouseY){
    if(angleZ + step > PI/3){
      angleZ = PI/3;
      } else {
      angleZ = angleZ + step;
      }
  } else if (mouseY < pmouseY){
    if(angleZ - step < -PI/3){
      angleZ = -PI/3;
      } else {
      angleZ = angleZ - step;
      }
  }
}

void mouseWheel(MouseEvent event) {
  change = 10*event.getCount();
}