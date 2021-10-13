class Mountains {
  String mountainSide;
  
  //coordinates
  float fixed_x1;
  float x1;
  float y1;
  float x2;
  float y2;
  float x3;
  float y3;
  
  float x4;
  float x5;
  float x6;
  float offset;
  color mountainColor[];
  int colorCount = 0;

  
  //move
  float speed;
  
  Mountains(){
    speed = 0.1;
  
    fixed_x1 = 1200/2; //width/2
    
    //right
    x1 = fixed_x1;
    y1 = sky; //100
    x2 = x1 + 100;
    y2 = y1 - 80;
    x3 = x1 + 200;
    y3 = y1;
    
    //left
    x4 = fixed_x1;
    x5 = x4 - 100;
    x6 = x1 - 200;
    
    offset = random(100,300);
    
    //one color per mountain
    for (float i=0; i<1200; i+= offset){
      mountainColor[colorCount] = int(random(100,300));
      colorCount += 1;
    }

  }
  
  void display(){
    //right-hand mountains
    for(float i=0; i<1200; i+=offset){
      mountainSide = "right";
      //mountain bases
      fill(114,98,38);
      noStroke();
      triangle(x1+i, y1, x2+i, y2, x3+i, y3);
    
      //snowy cap
      fill(225,231,237);
      triangle(x1 + 50 + i, y1 - 40, x2 + i, y2, x3 - 50 + i, y2 + 40);
      
      //increment color count for next mountain
      colorCount++;
    }
    
    //left-hand mountains
    for(float i=0; i<1200; i+=offset){
      mountainSide = "left";
      //mountain bases
      fill(114,98,38);
      noStroke();
      triangle(x4-i, y1, x5-i, y2, x6-i, y3);
    
      //snowy cap
      fill(225,231,237);
      triangle(x4 - 50 - i, y1 - 40, x5 - i, y2, x6 + 50 - i, y2 + 40);
    }
    
      

  
    }
  void move(){
    //right side
      x1 = x1 + speed;
      x2 = x2 + speed;
      x3 = x3 + speed;
      
      //left side
      x4 = x4 - speed;
      x5 = x5 - speed;
      x6 = x6 - speed;
    }
}
