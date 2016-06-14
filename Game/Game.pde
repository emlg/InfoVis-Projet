void settings() {
  size(500 , 500, P3D);
}
float boxX = 100;
float boxY = 10;
float boxZ = 100;

float valueX;
float valueZ;
float angleX = 0;
float angleZ = 0;
float change = 1;

Mover ball;
boolean shiftMode = false;
ArrayList<PVector> cylinders = new ArrayList<PVector>();

PGraphics bottomSquare;
int bottomSquareHeight = 100;
PGraphics topView;
int border = 5;
int topViewSize = bottomSquareHeight - 2*border;
float score = 0;
PGraphics scoreBoard;
int scoreBoardSize = topViewSize;

PGraphics barChart;
int barChartHeight = bottomSquareHeight - 3*border;
int barChartWidth;

HScrollBar scrollBar;
PImage sVid;
PImage sDetect;
Boolean isPaused = false;

void setup() {
  
  noStroke();
  ball = new Mover();
  bottomSquare = createGraphics(width, bottomSquareHeight, P2D);
  topView = createGraphics(topViewSize, topViewSize, P2D);
  scoreBoard = createGraphics(scoreBoardSize, scoreBoardSize, P2D);
  barChartWidth = width - topViewSize - scoreBoardSize - 4*border;
  barChart = createGraphics(barChartWidth, barChartHeight, P2D);
  scrollBar = new HScrollBar(3*border + topViewSize + scoreBoardSize, bottomSquareHeight - 2*border, barChartWidth, border);
  pushMatrix();
  translate(width/2, height/2, 0);
  valueX = width/2.0;
  valueZ = height/2.0;
  popMatrix();
  setupCam();

}

void draw() {
  computeAngles();
  // where getRotate would be a getter
  //for the rotation angle computed previously
  if (angles == null) {
    angleX = 0;
    angleZ = 0;
  } else {
    angleX = min(max( -angles.x, -PI/6), PI/6);
    angleZ = min(max( -angles.y, -PI/6), PI/6);
  }

  background(200);
  lights();
  
  if (!shiftMode ) {
    
    sVid = vid.copy();
    sVid.resize(64*2, 48*2);
    image(sVid, 0, 0);
    sDetect = detect.copy();
    sDetect.resize(64*2, 48*2);
    image(sDetect, 64*2 , 0);
    
    translate(width/2, height/2, 0);
    pushMatrix();
    translate(-width/2, height/2 -bottomSquareHeight, 0);
    drawBottomSquare();
    image(bottomSquare, 0, 0);
    drawTopView();
    image(topView, border, border);
    drawScoreBoard();
    image(scoreBoard, 2*border + topViewSize, border);
    drawBarChart();
    image(barChart, 3*border + topViewSize + scoreBoardSize, border);
    scrollBar.update();
    scrollBar.display();
    popMatrix();

    pushMatrix();
    rotateX(angleX - PI/2);
    rotateZ(angleZ);
    fill(150);
    box(boxX, boxY, boxZ);   
    for (int i = 0; i < cylinders.size(); i++) {
      fill(250, 160, 25);
      Cylinder newCylinder = new Cylinder();
      newCylinder.display(cylinders.get(i).x -width/2, -boxY/2- Cylinder.cylinderHeight, cylinders.get(i).y - height/2);
    }
    pushMatrix();
    ball.update(angleZ, angleX);
    ball.checkEdges();
    ball.checkCylinderCollision();
    ball.display();
    popMatrix();
    popMatrix();
  } else {
    translate(width/2, height/2, 0);
    background(135, 7, 40);
    fill(150);
    box(boxX, boxZ, boxY);
    for (int i = 0; i < cylinders.size(); i++) {
      fill(250, 160, 25);
      Cylinder newCylinder = new Cylinder();
      newCylinder.display(cylinders.get(i).x -width/2, cylinders.get(i).y - height/2, boxY/2);
    }
  } 
}