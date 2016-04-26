PImage binary(float threshold){
  PImage result = createImage(img.width, img.height, RGB);
  for(int i = 0; i < img.width * img.height; i++){
    if(brightness(img.pixels[i]) > threshold)
        result.pixels[i] = color(255);
    else
        result.pixels[i] = color(0);
  }
  return result;
}

void inverted(PImage result, float threshold){
  loadPixels();
  for(int i = 0; i < img.width * img.height; i++){
    if(brightness(img.pixels[i]) > threshold)
        result.pixels[i] = color(255, 255, 255);
    else
        result.pixels[i] = color(0, 0, 0);
  }
  updatePixels();
}