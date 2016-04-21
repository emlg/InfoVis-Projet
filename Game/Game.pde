void settings() {
  size(500, 500, P3D);
}
//dimensions de la box
float boxX = 200;
float boxY = 10;
float boxZ = 200;

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

HScrollbar scrollBar;

void setup() {
  noStroke();
  ball = new Mover();
  bottomSquare = createGraphics(width, bottomSquareHeight, P2D);
  topView = createGraphics(topViewSize, topViewSize, P2D);
  scoreBoard = createGraphics(scoreBoardSize, scoreBoardSize, P2D);
  barChartWidth = width - topViewSize - scoreBoardSize - 4*border;
  barChart = createGraphics(barChartWidth, barChartHeight, P2D);
  scrollBar = new HScrollbar(3*border + topViewSize + scoreBoardSize , bottomSquareHeight - 2*border, barChartWidth, border);
  pushMatrix();
  translate(width/2, height/2, 0);
  valueX = width/2.0;
  valueZ = height/2.0;
  popMatrix();

}

void draw() {
  background(200);
  lights();
  translate(width/2, height/2, 0);
  fill(150);
 
  if(!shiftMode){
    pushMatrix();
    translate(-width/2, height/2 -bottomSquareHeight,0);
    drawBottomSquare();
    image(bottomSquare, 0,0);
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
    rotateX(angleX);
    rotateZ(angleZ);
    box(boxX, boxY, boxZ);   
    for(int i = 0; i < cylinders.size(); i++){
      fill(250, 160,25);
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
    background(135, 7, 40);
    box(boxX, boxZ, boxY);
    for(int i = 0; i < cylinders.size(); i++){
      fill(250, 160,25);
      Cylinder newCylinder = new Cylinder();
      newCylinder.display(cylinders.get(i).x -width/2, cylinders.get(i).y - height/2, boxY/2);
    }
  }
  
}