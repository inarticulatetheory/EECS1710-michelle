class Faces {
  float x;
  float y;
  float w;
  float h;
  float z;
  PImage fur; //used to set texture on face
  PShape face;

  Faces(float cornerx_, float cornery_, float w_, float h_) {
    //OpenCV will pass detection points as corners
    x = (cornerx_ + (w/2)); //shift x to middle
    y = (cornery_ + (h/2)); //shift y to middle
    w = w_;
    h = h_;
    z = 0;
    
    fur = loadImage("fur.jpg");
    face = createShape(SPHERE, w/2);
    face.setTexture(fur);
    noStroke();    
    lights();
  }
  
  void display() {
    translate(x + (w/2), y + (h/2), 0);
    shape(face);
  }
  
  
  void update() {
    //update the sound waves with current location
    updateWaves(x + (w/2), y + (h/2), w, h);
    //z = h;
  }
  
}
