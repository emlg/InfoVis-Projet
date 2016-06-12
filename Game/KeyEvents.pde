void keyPressed(){
  if( key == CODED){
    if(keyCode == SHIFT){
      shiftMode = true;
      isPaused = true;
      cam.pause();
    }
  }
}

void keyReleased(){
  if(key == CODED){
    if(keyCode == SHIFT){
      shiftMode = false;
      isPaused = false;
      cam.play();
    }
  }
}