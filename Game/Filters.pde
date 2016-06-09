PImage hueMap(PImage img, float min, float max){
  PImage result = createImage(img.width, img.height, ALPHA);
  for(int i = 0; i < img.width * img.height; i++){
    if(hue(img.pixels[i]) < min || hue(img.pixels[i]) > max)
      result.pixels[i] = color(0);
    else
      result.pixels[i] = color(img.pixels[i]);
  }
  return result;
}


PImage saturationMap(PImage img, float min, float max){
  PImage result = createImage(img.width, img.height, RGB);
  for(int i = 0; i < img.width * img.height; i++){ 
    if(saturation(img.pixels[i]) < min || saturation(img.pixels[i]) > max)
      result.pixels[i] = color(0);
    else
      result.pixels[i] = color(img.pixels[i]);
  }
  return result;
}


PImage brightnessMap(PImage img, float min, float max){
  PImage result = createImage(img.width, img.height, RGB);
  for(int i = 0; i < img.width * img.height; i++){
    if(brightness(img.pixels[i]) < min || brightness(img.pixels[i]) > max)
      result.pixels[i] = color(0);
    else
      result.pixels[i] = color(img.pixels[i]);
  }
  return result;
}