PVector getIntersection(PVector line1, PVector line2) {
  float d = (cos(line2.y) * sin(line1.y)) - (cos(line1.y) * sin(line2.y));
  float x = ((line2.x * sin(line1.y)) - (line1.x * sin(line2.y))) / d;
  float y = (- (line2.x * cos(line1.y)) + (line1.x * cos(line2.y))) / d;
  return new PVector(x, y);
}

ArrayList<PVector> getIntersections(List<PVector> lines) {
  ArrayList<PVector> intersections = new ArrayList<PVector>();
  for (int i = 0; i < lines.size() - 1; i++) {
    PVector line1 = lines.get(i);
    for (int j = i + 1; j < lines.size(); j++) {
      PVector line2 = lines.get(j);
      PVector intersection = getIntersection(line1, line2);
      intersections.add(intersection);
      
      fill(255, 128,0);
      ellipse(intersection.x, intersection.y, 10,10);
    }
  }
  return intersections;
}

void displayQuads(List<PVector> lines){
  QuadGraph graph = new QuadGraph();
  graph.build(lines, img.width, img.height);
  List<int[]> quads = graph.findCycles();
  
  for (int[] quad : quads) {
    PVector l1 = lines.get(quad[0]);
    PVector l2 = lines.get(quad[1]);
    PVector l3 = lines.get(quad[2]);
    PVector l4 = lines.get(quad[3]);

    PVector c12 = getIntersection(l1, l2);
    PVector c23 = getIntersection(l2, l3);
    PVector c34 = getIntersection(l3, l4);
    PVector c41 = getIntersection(l4, l1);
    
    if(graph.isConvex(c12, c23, c34, c41) && graph.nonFlatQuad(c12, c23, c34, c41)&& graph.validArea(c12,c23,c34,c41,550000,100000)){
      Random random = new Random();
    fill(color(min(255, random.nextInt(300)), 
      min(255, random.nextInt(300)), 
      min(255, random.nextInt(300)), 50));
    quad(c12.x, c12.y, c23.x, c23.y, c34.x, c34.y, c41.x, c41.y);
    }
  }
  
}