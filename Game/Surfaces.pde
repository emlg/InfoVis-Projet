void drawBottomSquare(){
  bottomSquare.beginDraw();
  bottomSquare.background(110, 111, 150);
  bottomSquare.endDraw();
}

void drawTopView(){
  topView.beginDraw();
  topView.background(200);
  if(!cylinders.isEmpty()){
    topView.fill(250, 160,25);
    topView.noStroke();
    for(int i = 0; i< cylinders.size(); i++){
      float coordX = map(cylinders.get(i).x, width/2 - boxX/2, width/2 + boxX/2, 0, topViewSize);
      float coordY = map(cylinders.get(i).y, height/2 - boxZ/2, height/2 + boxZ/2, 0, topViewSize);
      topView.ellipse(coordX, coordY, 5,5);
    }
  }
  topView.fill(110);
  topView.ellipse(topViewSize/2 + ball.location.x* topViewSize/boxX, 
  topViewSize/2 + ball.location.y* topViewSize/boxZ, 2,2);
  topView.endDraw();
}

void drawScoreBoard(){
  scoreBoard.beginDraw(); 
  scoreBoard.background(110, 111, 150);
  scoreBoard.stroke(255);
  pushMatrix();
  scoreBoard.noFill();
  scoreBoard.rect(0,0, scoreBoardSize, scoreBoardSize);
  scoreBoard.text("Total score", 3, border + 5);
  scoreBoard.text(score, 3, border +17);
  scoreBoard.text("Velocity", 3, border +29);
  scoreBoard.text(ball.velocity.mag(), 3, border +41);
  popMatrix();
  scoreBoard.endDraw();
}

void drawBarChart(){
 barChart.beginDraw();
 int barWidth = 3;
 float scale = 1;
 float barHeight = score*scale;
 int currBarX = 0;
 barChart.rect(currBarX, 3*border, barWidth, barHeight);
 currBarX += barWidth;
 barChart.endDraw();
}