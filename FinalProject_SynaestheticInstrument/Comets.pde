class Comet {
  float x;
  float y;
  float z;
  float pz;
  float speed;
  
  Comet() {
    x = random(0, width);
    y = random(height/2);
    z = random(width);
    speed = random(1, 7);
    pz = z; //previous location
  }
  
  void update() {
    z = z - speed;
    if (z < 1){
      z = width;
      x = random(0, width);
      y = random(height/2);
      pz = z; //start "previous" at current z
    }
  
  }
  
  void display() {
    pushMatrix();
    //translate to center of window to draw
    translate(-width/2, -height/2);
      fill(255);
      noStroke();
      float sx = map(x/z, 0, 1, 0, width);
      float sy = map(y/z, 0, 1, 0, height);
      
      float r = map(z, 0, width, 3, 0);
      ellipse(sx, sy, r, r);
      
      float px = map(x/pz, 0, 1, 0, width);
      float py = map(y/pz, 0, 1, 0, height);
      
      pz = z;
      
      stroke(255);
      strokeWeight(0.25);
      line(px, py, sx, sy);
    popMatrix();
  }
}
