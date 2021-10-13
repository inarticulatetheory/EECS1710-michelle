class Sun {
  float y;
  float speed;
  
  Sun(){
    y = sky + 50;

  }
  
  void display(){
    noStroke();
    fill(247, 148, 17);
    ellipseMode(CENTER);
    ellipse(1200/2, y, 100, 100);
    }
  void rise(){
    speed = -0.1;
    y = y + speed;
    
    if (y < 0) {
      y = 0;
    }
  }
}
