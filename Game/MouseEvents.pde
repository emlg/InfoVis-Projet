/*void mouseDragged(){
 if(mouseY < height- bottomSquareHeight){
   valueZ += (mouseX- pmouseX) *change;
   valueX += (mouseY- pmouseY) *change;
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
 }
}*/

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

void mouseClicked(){
  if(shiftMode){
    PVector position = new PVector(mouseX, mouseY);
    PVector p2 = new PVector(mouseX - width/2, mouseY - height/2);
    PVector upLeft = new PVector(width/2f - boxX/2f, height/2f - boxZ/2f);
    PVector bottomRight =  new PVector(width/2f + boxX/2f, height/2f + boxZ/2f);
    if( position.x >= upLeft.x + Cylinder.cylinderBaseSize
     && position.x <= bottomRight.x - Cylinder.cylinderBaseSize
     && position.y >= upLeft.y + Cylinder.cylinderBaseSize
     && position.y <= bottomRight.y - Cylinder.cylinderBaseSize
     && ball.location.dist(p2) > ball.r + Cylinder.cylinderBaseSize){ 
        cylinders.add(position);
     }
  }
}