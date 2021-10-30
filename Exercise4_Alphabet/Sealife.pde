/*
CODE CITED
1. Skeleton of this code from 
    Moving vector tutorial from https://processing.org/tutorials/pvector
*/
class Sealife {

  PVector location;
  PVector velocity;
  PVector acceleration;
  float topspeed;
  PVector stop1; //will modify to create alphabet stops

  Sealife() {
    location = new PVector(random(width),random(height));
    velocity = new PVector(0,0);
    topspeed = 4;
  }

  void admin() {

    // Our algorithm for calculating acceleration:
    PVector stop1 = new PVector(width/3,height/2);
    PVector dir = PVector.sub(stop1,location);  // Find vector pointing towards mouse
    dir.normalize();     // Normalize
    dir.mult(0.5);       // Scale
    acceleration = dir;  // Set to acceleration

    // Motion 101!  Velocity changes by acceleration.  Location changes by velocity.
    velocity.add(acceleration);
    velocity.limit(topspeed);
    location.add(velocity);
  }

  void display() {
    stroke(0);
    fill(175);
    ellipse(location.x,location.y,16,16);
  }

  void checkBoundaries() {

    if (location.x > width) {
      location.x = 0;
    } else if (location.x < 0) {
      location.x = width;
    }

    if (location.y > height) {
      location.y = 0;
    }  else if (location.y < 0) {
      location.y = height;
    }

  }

}
