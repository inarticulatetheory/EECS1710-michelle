class BackgroundLife {
  float x, y;
  float r;
  float yspeed;
  float xspeed;
  int lifeAlpha;
  
  BackgroundLife() {
    r = random(20,50);
    yspeed = random(2);
    xspeed = random(5);
    x = -r*3; //random x start
    y = random(height); //start below window
    lifeAlpha = int(random(10,80));
  }
  
  void display() {
    noStroke();
    fill(0);
    //fill(25, 40, 64, lifeAlpha);
    ellipse(x, y, r*4, r*2);
    triangle(x-r*1.5, y, x-r*4, y+r/2, x-r*4, y-r/2);
    
    //ellipse(x, y, r, r);
  }
  
  void move() {
    y += yspeed;
    x += xspeed;
  }

}
