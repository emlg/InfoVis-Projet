void hueMap(PImage result, float min, float max){
  result.loadPixels();
  for(int i = 0; i < img.width * img.height; i++){
    if(hue(img.pixels[i]) < 255 * min || hue(img.pixels[i]) > 255 * max)
      result.pixels[i] = color(0);
    else
      result.pixels[i] = color(hue(img.pixels[i]));
  }
  result.updatePixels();
}