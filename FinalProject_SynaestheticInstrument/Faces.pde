class Faces {
  float x;
  float y;
  float w;
  float h;

  Faces(float x_, float y_, float w_, float h_) {
    x = x_;
    y = y_;
    w = w_;
  
  }
  
  void display() {
    fill(210,100);
    noStroke();
    ellipseMode(CORNER);
    ellipse(x, y, w-10, h);
  }

}
