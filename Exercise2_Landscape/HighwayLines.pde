class HighwayLines {
  
  //sizes
  float xTopOffset;
  float yTopOffset;
  float xBottomOffset;
  float len;
  float w;
  
  //coordinates
  float x1;
  float y1;
  float x2;
  float y2;
  float x3;
  float y3;
  float x4;
  float y4;
  
  //moving
  float speed;

  HighwayLines() {
    //sizes
    xTopOffset = 2;
    yTopOffset = 2;
    xBottomOffset = 5;
    len = 5;
    //w = width_;
    w = 1200; //figure out how to not have to hardcode this
    
    speed = 1;      
  }

  void paint() {  
    //coordinates
    x1 = w/2 - xTopOffset;
    y1 = sky + yTopOffset;
    x2 = w/2 + xTopOffset;
    y2 = sky + yTopOffset;
    x3 = w/2 + xBottomOffset;
    y3 = y1 + len;
    x4 = w/2 - xBottomOffset;
    y4 = y2 + len;
    
  
    //road lines
    fill(245, 237, 153);
    noStroke();
    quad(x1, y1, x2, y2, x3, y3, x4, y4);
    
  }
  
  
  void drive() { 
    len++;
    
    if (len > height - sky) {
      len = height - sky;
    }
  }
    
    /*
    for (float j=len; j<100; j+=0.5) {
        len++;
        xBottomOffset++;
    }

      /*
      //but len should max out
      for (float j=len; j<100; j+=0.5) {
        len = j;
        
        for (int i=2; i<10; i+=0.5) {
          //xTopOffset += 0.004;
          //yTopOffset += 0.05;
          //xBottomOffset += 0.006;
          //yBottomOffset += 0.05;
        }
      }
      */
      
  //}
}
