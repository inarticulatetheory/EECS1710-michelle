class Firefly{
    //variables for color
    float redVal;
    float greenVal;
    float blueVal;
    float alphaVal;
    
    //variables to move the firefly
    float xjitter;
    float yjitter;
    float x;
    float y;
    float xspeed;
    float yspeed;
    float w;
    float wing1x;
    float wing1y;
    float wing2x;
    float wing2y;
    
    //variables to kill the firefly
    int savedTime;
    int dyingTime = int(random(5000, 40000)); //seconds until dying
    int willDie;
    int isDead;
    float deathX;
    float deathY; 
  
    //Constructor
    Firefly(float tempx, float tempy, float tempw, float tempxspeed, float tempyspeed, int tempWillDie) {
      xspeed = tempxspeed;
      yspeed = tempyspeed;
      x = tempx;
      y = tempy;
      w = tempw;
      willDie = tempWillDie;
      
      //initial body colour
      redVal = random(210,231);
      greenVal = random(140,163);
      blueVal = random(40,64);
      
      //start timer
      savedTime = millis();

    }
    
    void display() {
      /* === DRAW FIREFLY === */
      
      //alpha
      alphaVal = random(0,255);
      
      //initial wing radians
      wing1x = random(270,340);
      wing1y = 360;
      wing2x = random(200,260);
      wing2y = 280;
      
      noStroke();
      ellipseMode(CENTER);
    
      //halo
      stroke(240, 255, 155, random(0,40));
      noFill();
      arc(x, y, w+4, w+4, radians(10), radians(210));
      
      //wings
      fill(250, random(5,80));
      arc(x-1, y-2, 35, 35, radians(wing1x), radians(wing1y));
      arc(x+1, y-1, 35, 35, radians(wing2x), radians(wing2y));
      
      //firefly body
      noStroke();
      fill(redVal, greenVal, blueVal, alphaVal);
      arc(x, y, w, w, 0, PI+QUARTER_PI, CHORD);
    }
    
    void fly() {
      xjitter = random(-2,3);
      yjitter = random(-3,2);
      x = x + xspeed + xjitter;
      y = y + yspeed + yjitter;
      
      //set boundaries
      topBoundary = 90 + (40/2); //(bottom of lid y) + (bottom of lid height/2)
      bottomBoundary = (height/2 + 15) + (470/2); //(jar y) + (jar height/2)
      //(width of canvas - width of jar) divide empty space in 2 (half for each side of jar;
      leftBoundary = (width - 400) / 2;  
      rightBoundary = (width/2) + (400/2); //(jar x) + (jar width/2);
      /* === END COORDINATES / SPEED / BOUNDARIES === */ 
      
      //adjust boundaries to accommodate for firefly width and height
      //topBoundary has no adjustment
      bottomBoundary = bottomBoundary - (w/2) - 8;
      leftBoundary = leftBoundary + (w/2) + 8;  
      rightBoundary = rightBoundary - (w/2) - 8; 
  
      /* === START BOUND FIREFLY TO JAR === */
        if ((x > rightBoundary) || (x < leftBoundary)) {
          xspeed = xspeed * -1;
        }
        
        if ((y > bottomBoundary) || (y < topBoundary)) {
          yspeed = yspeed * -1;
        }
        //constrain x and y so firefly doesn't fly out of jar
        x = constrain(x, leftBoundary, rightBoundary);
        y = constrain(y, topBoundary, bottomBoundary);
      /* === END BOUND FIREFLY TO JAR === */
      
      //if this firefly has been randomly chosen to die, run the "die" function
      if (willDie == 1) {
        die();
      }
    }
  
  void die() {
    int passedTime = millis() - savedTime;
    
     //get coordinates to die
     deathX = random(leftBoundary, rightBoundary);
     deathY = random(bottomBoundary - 50, height - 50); 
    
    //if enough time has passed, begin dying
    if (passedTime > dyingTime) {    
      //make sure firefly dies at the bottom of the jar
      //and turn to black
      if (y > deathY) {
        y = deathY;
        redVal = random(60, 70);
        greenVal = random(33, 42);
        blueVal = random(33, 42);
        alphaVal = random(30,120);
        isDead = 1; //begin death process
      }  
    }
        //if enough time has passed, die
    if (passedTime > (dyingTime + 5000)) {    
      //once firefly is officially dead, stick to bottom of jar
      y = deathY;
    }
  }
}
