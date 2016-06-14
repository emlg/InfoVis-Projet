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