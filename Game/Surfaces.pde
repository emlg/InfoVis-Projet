void drawBottomSquare(){
  bottomSquare.beginDraw();
  bottomSquare.background(110, 111, 150);
  bottomSquare.endDraw();
}

void drawTopView(){
  topView.beginDraw();
  topView.background(200);
  topView.noStroke();
  if(!cylinders.isEmpty()){
    topView.fill(250, 160,25);
    for(int i = 0; i< cylinders.size(); i++){
      float coordX = map(cylinders.get(i).x, width/2 - boxX/2, width/2 + boxX/2, 0, topViewSize);
      float coordY = map(cylinders.get(i).y, height/2 - boxZ/2, height/2 + boxZ/2, 0, topViewSize);
      topView.ellipse(coordX, coordY, Cylinder.cylinderBaseSize*2*topViewSize/boxX , Cylinder.cylinderBaseSize*2*topViewSize/boxX);
    }
  }
  topView.fill(100,0,0);
  topView.ellipse(topViewSize/2 + ball.location.x* topViewSize/boxX, 
  topViewSize/2 + ball.location.y* topViewSize/boxZ, ball.r*2*topViewSize/boxX, ball.r*2*topViewSize/boxX);
  topView.endDraw();
}

void drawScoreBoard(){
  scoreBoard.beginDraw(); 
  scoreBoard.background(110, 111, 150);
  pushMatrix();
  scoreBoard.noFill();
  scoreBoard.stroke(255);
  scoreBoard.strokeWeight(3);
  scoreBoard.rect(0,0, scoreBoardSize, scoreBoardSize);
  scoreBoard.text("Total Score:\n" + round2(score) + "\nvelocity: \n" + round2(ball.velocity.mag()), 3, border + 5);
  popMatrix();
  scoreBoard.endDraw();
}

int count = 0;
ArrayList<Integer> barChartValues = new ArrayList<Integer>();
  int maxNb = 40;
  float playerMax = 0;
  int maxBarHeight = barChartHeight - 3;
  float barHeight = 0;
  
void drawBarChart(){
  barChart.beginDraw();
  //selecting the values and store

  int barWidth = (int) (5*scrollBar.getPos());

  barChart.background(110, 111, 150);
  count +=1;
  if (count >= maxNb){
    count = 0;
    barChartValues.add((int)Math.round(score));
    if(playerMax < score){
      playerMax = score;
    }
  }
  for(int i = 0; i < barChartValues.size(); i++){
   int currScore= 0; 
   if(barChartValues.get(i)> 0) {
     currScore = barChartValues.get(i);
   }
   barHeight = currScore* maxBarHeight/playerMax;
   barChart.noStroke();
   barChart.fill(130, 90, 50);
   barChart.rect(i*barWidth, maxBarHeight - barHeight, barWidth, barHeight);
 }
  barChart.endDraw();
}