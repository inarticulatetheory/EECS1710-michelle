class Faces {
  float x;
  float y;
  float w;
  float h;
  float z;

  Faces(float cornerx_, float cornery_, float w_, float h_) {
    //OpenCV will pass detection points as corners
    x = (cornerx_ + (w/2)); //shift x to middle
    y = (cornery_ + (h/2)); //shift y to middle
    w = w_;
    h = h_;
    z = 0;
  }
  
  void display() {
    translate(x + (w/2), y + (h/2), 0);
    
    fill(255, 253, 201, 100);
    noStroke();
    ellipseMode(CENTER);
    ellipse(0, 0, w*0.75, h*0.75);
    
    noStroke();
    lights();
    sphere(50);
  }
  
  void update() {
    //update the sound waves with current location
    updateWaves(x + (w/2), y + (h/2), w, h);
    //z = h;
  }

}
