class Faces {
  float x;
  float y;
  float w;
  float h;
  float z;
  PImage moonTexture; //used to set texture on face; from http://planetpixelemporium.com/
  PShape face;

  Faces(float cornerx_, float cornery_, float w_, float h_) {
    //OpenCV will pass detection points as corners
    x = (cornerx_ + (w/2)); //shift x to middle
    y = (cornery_ + (h/2)); //shift y to middle
    w = w_;
    h = h_;
    z = 0;
    
    //sphere setup
    moonTexture = loadImage("moonmap4k.jpg");
    noStroke();
    sphereDetail(40);
    face = createShape(SPHERE, w/2);
    face.setTexture(moonTexture);
    //noStroke();    
    //lights();
    //updateOrbitingLight(); CHANGE
 
  }
  
  void display() {
    translate(x + (w/2), y + (h/2), z);
    shape(face);
  }
  
  
  void update() {
    /*
    * BUG: was chopping up texture
    //spin face on axis
    pushMatrix();
      rotateY(PI * frameCount / 500);
      shape(face);
    popMatrix();
    */
  
    //update the sound waves with current location
    updateNoise(x + (w/2), y + (h/2), w, h, z);
    z = h;
  }
  
}
