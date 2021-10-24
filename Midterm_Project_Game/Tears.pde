class Tears {
  
  /* ===== VARIABLES START ===== */
  //location variables
  float tear_width = 25;
  float tear_x1;
  float tear_y1;
  float tear_x2; //tear duct
  float tear_y2; //tear duct
  float tear_x3;
  float tear_y3;
  
  //display variables
  PVector position;
  color tearColor = color(188, 233, 255);
  color tearAccent = color(255);
  int tearAlpha = 255; //opacity of tear, used to make tear disappear in burst() 

  //movement variables
  float speed = 5;
  
  //action variables
  boolean active = true; //is tear "active"
  /* ===== VARIABLES END ===== */

  
  /* ===== START CONSTRUCTOR ===== */
  Tears(float x, float y){
    position = new PVector(x, y);
  }
  /* ===== END CONSTRUCTOR ===== */

  
  /* ===== TEAR CRYING START ===== */
  void crying(){
    admin();
    draw();
  }
  /* ===== TEAR CRYING END ===== */
  
  
  /* ===== TEAR ADMIN START ===== */
  void admin(){
    position.y += speed;
    
    //if active and hits bottom (includes tide)
    if (active && (position.y + tear_width/2 > bottom)) {
      active = false;
      tide = tide + 4; //add to puddle
    }
  }
  /* ===== TEAR ADMIN END ===== */
  
  
  /* ===== DRAW TEAR START ===== */
  void draw() {
    fill(tearColor, tearAlpha);
 
    //bulb of tear
    ellipse(position.x, position.y + tear_width * 3,tear_width,tear_width);
    
    //top of tear
    tear_x1 = position.x - (tear_width/2);
    tear_y1 = position.y + tear_width * 3;
    tear_x2 = position.x; //tear duct
    tear_y2 = position.y; //tear duct
    tear_x3 = position.x + (tear_width/2);
    tear_y3 = position.y + tear_width * 3;
    triangle(tear_x1, tear_y1, tear_x2, tear_y2, tear_x3, tear_y3);
    
    //accent
    fill(tearAccent);
    ellipse(position.x - tear_width/5,tear_y1 - tear_width/4,tear_width/3,tear_width);
}
  /* ===== DRAW TEAR END ===== */
}
