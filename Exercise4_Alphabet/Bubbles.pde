class Bubbles {
  float x, y;
  float r;
  float yspeed;
  float xspeed;
  int bubbleAlpha;
  
  Bubbles() {
    r = random(5,20);
    yspeed = random(3);
    xspeed = random(1);
    x = random(width); //random x start
    y = height + r*3; //start below window
    bubbleAlpha = int(random(10,80));
  }
  
  void display() {
    noStroke();
    fill(255, bubbleAlpha);
    ellipse(x, y, r, r);
  }
  
  void move() {
    y -= yspeed;
    x += xspeed;
  }

}
