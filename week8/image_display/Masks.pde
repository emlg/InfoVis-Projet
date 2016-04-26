void convolute(PImage img, PImage result) {
  float[][] kernel = { { 0, 0, 0 },
                       { 0, 2, 0 },
                       { 0, 0, 0 }};
                       
   float[][] kernel2 = { { 0, 1, 0 },
                       { 1, 0, 1 },
                       { 0, 1, 0 }};             

  float weight = 1.f;
  int n = 3;
  result.loadPixels();
  for(int i = 1; i < img.height -1; i++){
      for(int j = 1; j< img.width -1; j++){
        int value = 0;
        for(int k = 0; k < n; k++){
          for(int l = 0; l < n; l++){
            value += brightness((int) (img.pixels[(i - n/2 +k)* img.width + (j - n/2 +l)]* kernel[k][l]));
          }
        }
        result.pixels[i*img.width + j] = (int)(value/weight);
        println((int)(value/weight));
      }
    }
  result.updatePixels();
}