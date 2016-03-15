class Mover {
  PVector location;
  PVector velocity;
  PVector gravity;
  PVector friction;
  
  float r;
  float gravityCst = 0.9;
  float normalForce =1;
  float mu = 0.1;
  float frictionMagnitude = normalForce*mu;
  
  Mover() {
    location = new PVector(0, 0);
    velocity = new PVector(1, 1);
    
  }
  void update(float angleZ, float angleX) {
    gravity = new PVector(sin(angleZ)*gravityCst, sin(angleX)*gravityCst);
    friction = velocity.copy();
    friction.mult(-1);
    friction.normalize();
    friction.mult(frictionMagnitude);
    location.add(velocity.add(friction.add(gravity)));
    
  }
  void display() {
    noStroke();
    fill(100,0,0);
    r = 10;
    pushMatrix();
    translate(location.x, location.y, 5+r);
    sphere(r);
    popMatrix();
  }
  
  void checkEdges() {
    if (location.x > 50 - r/2) {
      location.x = 50 -r/2;
      velocity.x = -1*velocity.x;
    }
    else if (location.x < r/2 -50 ) {
      location.x = r/2- 50;
      velocity.x = -1*velocity.x;
    }
    if (location.y > 50- r/2) {
      location.y = 50- r/2;
      velocity.y = -1*velocity.y;
    }
    else if (location.y < r/2 - 50) {
      location.y = r/2 - 50;
      velocity.y = -1*velocity.y;
    }
  }
}