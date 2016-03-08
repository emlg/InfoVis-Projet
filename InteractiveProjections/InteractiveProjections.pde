float depth = 2000;

void settings() {
  size (500, 500, P3D);
}
void setup() {
    noStroke();
}

int scale = 1;
float angleX = 0;
float angleY = 0;

void draw() {
  background(200);
  directionalLight(50,100,125,0,-1,0);
  camera(width/2, height/2, depth,250,250,0,0,1,0);
  ambientLight(102,102,102);
  translate(width/2, height/2, 0);
  float rz = map(mouseY,0, height, 0 ,PI);
  float ry = map(mouseX, 0, width, 0, PI);
  rotateZ(rz);
  rotateY(ry);
  for (int x = -2; x <= 2; x++) {
    for (int y = -2; y <= 2; y++) {
      for (int z = -2; z <= 2; z++) {
        pushMatrix();
        translate(100 * x, 100 * y, -100 * z);
        box(50);
        popMatrix();
      }
    }
  }
  /*box(100, 80, 60);
  translate(100, 0, 0);
  sphere(50);*/
}

void mouseDragged(){
  if(mouseY > pmouseY){
    scale = scale +1;
  } else if (mouseY< pmouseY) {
    if(scale - 1 <0) {
      scale = 0;
    } else {
    scale = scale -1;
    }
  }
}

void keyPressed() {
  if (key == CODED) {
    if (keyCode == UP) {
      depth -= 50;
    }
    else if (keyCode == DOWN) {
      depth += 50;
    }
  }
}

/*void keyPressed(){
  if(key == CODED){
    if(keyCode == UP){
      angleX = (angleX + PI/8) % (2*PI);
    } else if(keyCode == DOWN) {
      angleX = (angleX - PI/8) % (2*PI);
    } else if(keyCode == RIGHT) {
      angleY = (angleY + PI/8) % (2*PI);
    } else if (keyCode == LEFT) {
      angleY = (angleY - PI/8) % (2*PI);
    }
  }
}*/

class My2DPoint {
  float x;
  float y;
  My2DPoint(float x, float y) {
    this.x = x;
    this.y = y;
  }
}

class My3DPoint {
  float x;
  float y;
  float z;
  My3DPoint(float x, float y, float z) {
    this.x = x;
    this.y = y;
    this.z = z;
  }
}

My2DPoint projectPoint(My3DPoint eye, My3DPoint p) {
    float[][] matrixT = {{1, 0, 0, -eye.x},
                    {0,1,0, - eye.y},
                    {0,0,1,-eye.z},
                    {0,0,0,1}};
    float[][] matrixP = {{1,0,0,0},
                   {0,1,0,0},
                   {0,0,1,0},
                   {0,0, 1/(-eye.z),0}};
    float[][] transformation = multiplyMatrix(matrixP, matrixT);
    float[] point = {p.x, p.y, p.z , 1};
    float[] result = multiplyVector(transformation, point);
    return new My2DPoint(result[0]/result[3], result[1]/result[3]);
}

float[][] multiplyMatrix(float[][] A, float[][] B) {
  float[][] result = new float[A.length][B[0].length];
  for(int i =0; i<A.length; i++){
    for(int j =0; j< B[0].length; j++){
        for(int k = 0; k <A.length; k++){
           result[i][j] += A[i][k]*B[k][j];
        }
    }
  }
  return result;
}

float[] multiplyVector(float[][] A, float[] vect) {
  float[] result = new float[A.length];
  for(int i =0; i< A.length; i++){
    for(int k = 0; k< vect.length; k++){
      result[i] += A[i][k]* vect[k];
    }
  }
  
  return result;
}


class My2DBox {
  My2DPoint[] s;
  My2DBox(My2DPoint[] s) {
    this.s = s;
  }
  void render(){
    // Complete the code! use only line(x1, y1, x2, y2) built-in function.
    line(s[0].x, s[0].y, s[1].x, s[1].y);
    line(s[1].x, s[1].y, s[2].x, s[2].y);
    line(s[2].x, s[2].y, s[3].x, s[3].y);
    line(s[0].x, s[0].y, s[3].x, s[3].y);
    line(s[0].x, s[0].y, s[4].x, s[4].y);
    line(s[1].x, s[1].y, s[5].x, s[5].y);
    line(s[2].x, s[2].y, s[6].x, s[6].y);
    line(s[3].x, s[3].y, s[7].x, s[7].y);
    line(s[4].x, s[4].y, s[5].x, s[5].y);
    line(s[5].x, s[5].y, s[6].x, s[6].y);
    line(s[6].x, s[6].y, s[7].x, s[7].y);
    line(s[4].x, s[4].y, s[7].x, s[7].y);
  }
}

class My3DBox {
  My3DPoint[] p;
  My3DBox(My3DPoint origin, float dimX, float dimY, float dimZ){
      float x = origin.x;
      float y = origin.y;
      float z = origin.z;
      this.p = new My3DPoint[]{new My3DPoint(x,y+dimY,z+dimZ),
                                new My3DPoint(x,y,z+dimZ),
                                new My3DPoint(x+dimX,y,z+dimZ),
                                new My3DPoint(x+dimX,y+dimY,z+dimZ),
                                new My3DPoint(x,y+dimY,z),
                                origin,
                                new My3DPoint(x+dimX,y,z),
                                new My3DPoint(x+dimX,y+dimY,z)
                                };
}
My3DBox(My3DPoint[] p) {
  this.p = p;
  }
}

My2DBox projectBox (My3DPoint eye, My3DBox box) {
  My3DPoint[] points = box.p;
  My2DPoint[] result = new My2DPoint[points.length];
  for(int i = 0; i< points.length; i++){
    result[i] = projectPoint(eye, points[i]);
  }
  return new My2DBox(result);
}

float[] homogeneous3DPoint (My3DPoint p) {
  float[] result = {p.x, p.y, p.z , 1};
  return result;
}

float[][] rotateXMatrix(float angle) {
  return(new float[][] {{1, 0 , 0 , 0},
                        {0, cos(angle), sin(angle) , 0},
                        {0, -sin(angle) , cos(angle) , 0},
                        {0, 0 , 0 , 1}});
}
float[][] rotateYMatrix(float angle) {
  return(new float[][] {{cos(angle), 0 , sin(angle) , 0},
                        {0, 1, 0 , 0},
                        {-sin(angle), 0 , cos(angle) , 0},
                        {0, 0 , 0 , 1}});
}
float[][] rotateZMatrix(float angle) {
  return(new float[][] {{cos(angle), -sin(angle) , 0 , 0},
                        {sin(angle), cos(angle), 0 , 0},
                        {0, 0 , 1 , 0},
                        {0, 0 , 0 , 1}});
}
float[][] scaleMatrix(float x, float y, float z) {
  return(new float[][] {{x, 0 , 0 , 0},
                        {0, y, 0 , 0},
                        {0, 0 , z , 0},
                        {0, 0 , 0 , 1}});
}
float[][] translationMatrix(float x, float y, float z) {
  return(new float[][] {{1, 0 , 0 , x},
                        {0, 1, 0 , y},
                        {0, 0 , 1 , z},
                        {0, 0 , 0 , 1}});
}

My3DBox transformBox(My3DBox box, float[][] transformMatrix) {
  //Complete the code! You need to use the euclidian3DPoint() function given below.
  My3DPoint[] points = box.p;
  My3DPoint[] result = new My3DPoint[points.length];
  for(int i =0; i < points.length; i++){
    float[] point = {points[i].x, points[i].y,points[i].z, 1 };
    result[i] = euclidian3DPoint(multiplyVector(transformMatrix, point));
  }
  return new My3DBox(result);
}

My3DPoint euclidian3DPoint (float[] a) {
    My3DPoint result = new My3DPoint(a[0]/a[3], a[1]/a[3], a[2]/a[3]);
    return result;
}