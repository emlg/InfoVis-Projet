void keyPressed(){
  if( key == CODED){
    if(keyCode == SHIFT){
      shiftMode = true;
      
    }
  }
}

void keyReleased(){
  if(key == CODED){
    if(keyCode == SHIFT){
      shiftMode = false;
    }
  }
}