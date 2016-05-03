ArrayList<PVector> getIntersections(ArrayList<PVector> lines) {
  ArrayList<PVector> intersections = new ArrayList<PVector>();
  for (int i = 0; i < lines.size() - 1; i++) {
    PVector line1 = lines.get(i);
    for (int j = i + 1; j < lines.size(); j++) {
      PVector line2 = lines.get(j);
      // compute the intersection and add it to ’intersections’
      // draw the intersection
      float d = cos(line2.y)*sin(line1.y) - cos(line1.y)*sin(line2.y);
      float x = (line2.x*sin(line1.y) - line1.x*sin(line2.y))/d;
      float y = (-line2.x*cos(line1.y) + line1.x*cos(line2.y))/d;
      intersections.add(new PVector(x,y));
      fill(255, 128, 0);
      ellipse(x, y, 10, 10);
    }
  }
  return intersections;
}