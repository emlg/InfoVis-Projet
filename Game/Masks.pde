PImage convolute(PImage img) {
  float[][] kernel = {
    { 3, 5, 9, 5, 3 }, 
    { 5, 9, 12, 9, 5 }, 
    { 9, 12, 15, 12, 9 }, 
    { 5, 9, 12, 9, 5 }, 
    { 3, 5, 9, 5, 3 }};

  float weight = 20.f;
  PImage result = createImage(img.width, img.height, ALPHA);

for (int i = 2; i < img.width - 2; i++) {
    for (int j = 2; j <  img.height - 2; ++j) {
      float sum = 0;
      for (int kernelX = -2; kernelX <= 2; ++kernelX) {
        for (int kernelY = -2; kernelY <= 2; ++kernelY) {
          int index = i + kernelX  + img.width * (j + kernelY);
          sum += brightness(img.pixels[index]) * kernel[kernelX + 2][kernelY + 2];
        }
      }
      int imgColor = Math.round(min(sum / weight, 255));
      result.pixels[i + j * img.width] = color(imgColor);
    }
  }
  return result;
}

PImage sobel(PImage img) {
  float[][] hKernel = { { 0, 1, 0 }, 
                        { 0, 0, 0 }, 
                        { 0, -1, 0 } };
  float[][] vKernel = { { 0, 0, 0 }, 
                        { 1, 0, -1 }, 
                        { 0, 0, 0 } };
  PImage result = createImage(img.width, img.height, ALPHA);
  // clear the image
  for (int i = 0; i < img.width * img.height; i++) {
    result.pixels[i] = color(0);
  }

  float max = 0;
  float[] buffer = new float[img.width * img.height];

  for (int i = 1; i < img.width - 1; i++) {
    for (int j = 1; j <  img.height - 1; ++j) {
      float sum_h = 0;
      float sum_v = 0;
      for (int kernelX = -1; kernelX <= 1; ++kernelX) {
        for (int kernelY = -1; kernelY <= 1; ++kernelY) {
          int index = i + kernelX  + img.width * (j + kernelY);
          sum_h += (float) img.pixels[index] * hKernel[kernelX + 1][kernelY + 1];
          sum_v += (float) img.pixels[index] * vKernel[kernelX + 1][kernelY + 1];
        }
      }
      float sum = sqrt(pow(sum_h, 2) + pow(sum_v, 2));
      if (max < sum) {
        max = sum;
      }

      buffer[i + j * img.width] = sum;
    }
  }
  for (int y = 2; y < img.height - 2; y++) // Skip top and bottom edges
    for (int x = 2; x < img.width - 2; x++) // Skip left and right
      if (buffer[y * img.width + x] > (int)(max * 0.3f)) // 30% of the max
        result.pixels[y * img.width + x] = color(255);
      else
        result.pixels[y * img.width + x] = color(0);
  return result;
}