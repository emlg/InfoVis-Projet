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
      
      //fill(255, 128,0);
      //ellipse(intersection.x, intersection.y, 10,10);
    }
  }
  return intersections;
}