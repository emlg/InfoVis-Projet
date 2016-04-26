void binary(PImage result, float threshold){
  loadPixels();
  for(int i = 0; i < img.width * img.height; i++){
    if(brightness(img.pixels[i]) <= (int)(255 * threshold))
        result.pixels[i] = color(0);
    else
        result.pixels[i] = color(255);
  }
  updatePixels();
}

void inverted(PImage result, float threshold){
  loadPixels();
  for(int i = 0; i < img.width * img.height; i++){
    if(brightness(img.pixels[i]) <= (int)(255 * threshold))
        result.pixels[i] = color(255, 255, 255);
    else
        result.pixels[i] = color(0, 0, 0);
  }
  updatePixels();
}