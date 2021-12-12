class Eyes {
  float x;
  float y;
  float w;
  float h;

  Eyes(float cornerx_, float cornery_, float w_, float h_) {
    //OpenCV will pass detection points as corners
    x = (cornerx_ + (w/2)); //shift x to middle
    y = (cornery_ + (h/2)); //shift y to middle
    w = w_;
    h = h_;
  }
  
  void display() {
    fill(0, 80);
    noStroke();
    ellipseMode(CENTER);
    ellipse(x + (w/2), y + (h/2), w*0.25, h*0.25);
  }
  
  void update() {
    //nothing so far
  }

}
