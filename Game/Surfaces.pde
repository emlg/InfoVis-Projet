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
  scoreBoard.stroke(255);
  pushMatrix();
  scoreBoard.noFill();
  scoreBoard.rect(0,0, scoreBoardSize, scoreBoardSize);
  scoreBoard.text("Total Score:\n" + score + "\nvelocity: \n" + round2(ball.velocity.mag()), 3, border + 5);
  popMatrix();
  scoreBoard.endDraw();
}

void drawBarChart(){
  //selecting the values and store
  int count = 0;
  int maxNb = 40;
  ArrayList<Integer> barChartValues = new ArrayList<Integer>();
  
  float playerMax = 0;
  int maxBarHeight = barChartHeight - 3;
  int barWidth = (int) (5*scrollBar.getPos());
  float barHeight = 0;
 
  barChart.beginDraw();
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
   barChart.rect(i*barWidth, maxBarHeight - barHeight, barWidth, barHeight);
 }
  barChart.endDraw();
}