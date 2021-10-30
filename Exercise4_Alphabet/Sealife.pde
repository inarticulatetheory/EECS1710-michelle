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
  PVector stop1, stop2; //will modify to create alphabet stops

  Sealife() {
    //location = new PVector(random(width),random(height));
    stop1 = new PVector(width/3,height - height/3);
    stop2 = new PVector(width - width/3, height - height/3);
    location = new PVector(random(0, stop1.x), random(height, stop1.y));
    velocity = new PVector(0,0);
    topspeed = 4;
  }

  void admin() {

    // Our algorithm for calculating acceleration:
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
    noStroke();
    fill(175);
    ellipse(location.x,location.y,8,8);
  }
  
  void switchStops() {

    if (location.x > stop1.x) {
      location.x = 0;
    }

    if (location.y > stop1.y) {
      location.y = 0;
    }

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
