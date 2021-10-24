class Bubbles {
  
  /* ===== VARIABLES START ===== */
  //display variables
  PVector position, target, velocity;
  float x;
  float y;
  float radius, w, m; //w = bubble width
  PVector bubbleSize;
  
  //visual elements
  color bubbleColor = color(255); //color(random(127)+127, random(127)+127, random(127)+127);
  
  //action variables
  boolean active = true;

  /* ===== VARIABLES END ===== */
  
  /* ===== CONSTRUCTOR START ===== */
  Bubbles(float x, float y, float _w, int _c) {    
    position = new PVector(x, y); 
    bubbleColor = color(_c);
    velocity = PVector.random2D();
    velocity.mult(0.3);
    w = _w;
    radius = w/2;
    m = radius * 0.1;
    
    //used for collision detection since position variables are also PVectors
    bubbleSize = new PVector(w, w);  

    
    //get variables for collision detection
    //currentWord = _currentBubble;
    //otherWords = _otherBubbles;
  }
  /* ===== CONSTRUCTOR END ===== */
  
  
  /* ===== RUN BUBBLES START ===== */
  void run() {
    admin();
    draw();
    //move();
    checkBoundaryCollision();
  }
  /* ===== RUN BUBBLES END ===== */
  
  /* ===== ADMIN START ===== */
  void admin(){
    position.add(velocity);
    
    for (Tears t : eye.tears) {
      //if this bubble is active AND hit with tear
      if (active && tempHitDetection(position, t.position, bubbleSize)) {
        active = false;
        burst();
      }
    }
  }
  /* ===== ADMIN END ===== */

  
  /* ===== DRAW BUBBLES START ===== */
  void draw() {    
    //draw bubble
    fill(bubbleColor, 80); //apply 80 alpha
    ellipseMode(CENTER);
    ellipse(position.x, position.y, w, w);
    
    //draw reflection
    fill(255);
    ellipse(position.x - w/5, position.y - w/4, w/5, w/4);
  }
  /* ===== DRAW BUBBLES END ===== */


  /* ===== COLLIDE METHODS START ===== */
  //Collision detection adapted from Processing.org bouncy bubbles example
  // Attributed to Keith Peters
  // https://processing.org/examples/bouncybubbles.html
  // --- and ---
  // Processing.org Circle Collision with Swapping Velocities
  // Attributed to Ira Greenberg
  // https://processing.org/examples/circlecollision.html

  void checkBoundaryCollision() {
    bottom = height - tide;
    if (position.x > width-radius) {
      position.x = width-radius;
      velocity.x *= -1;
    } else if (position.x < radius) {
      position.x = radius;
      velocity.x *= -1;
    } else if (position.y > bottom-radius) {
      position.y = bottom-radius * 1.5;
      velocity.y *= -1;
    } else if (position.y < radius) {
      position.y = radius;
      velocity.y *= -1;
    }
  }
  
  void checkCollision(Bubbles other) {
    /*  
    code attributed to Ira Greenberg
    https://processing.org/examples/circlecollision.html
    */
    
    // Get distances between bubbles
    PVector distanceVect = PVector.sub(other.position, position);

    // Calculate magnitude of the vector separating the bubbles
    float distanceVectMag = distanceVect.mag();

    // Minimum distance before they are touching
    float minDistance = radius + other.radius;

    if (distanceVectMag < minDistance) {
      float distanceCorrection = (minDistance-distanceVectMag)/2.0;
      PVector d = distanceVect.copy();
      PVector correctionVector = d.normalize().mult(distanceCorrection);
      other.position.add(correctionVector);
      position.sub(correctionVector);

      // get angle of distanceVect
      float theta  = distanceVect.heading();
      // precalculate trig values
      float sine = sin(theta);
      float cosine = cos(theta);

      /* bTemp will hold rotated ball positions. You 
       just need to worry about bTemp[1] position*/
      PVector[] bTemp = {
        new PVector(), new PVector()
      };

      /* this bubble's position is relative to the other
       so you can use the vector between them (bVect) as the 
       reference point in the rotation expressions.
       bTemp[0].position.x and bTemp[0].position.y will initialize
       automatically to 0.0, which is what you want
       since b[1] will rotate around b[0] */
      bTemp[1].x  = cosine * distanceVect.x + sine * distanceVect.y;
      bTemp[1].y  = cosine * distanceVect.y - sine * distanceVect.x;

      // rotate Temporary velocities
      PVector[] vTemp = {
        new PVector(), new PVector()
      };

      vTemp[0].x  = cosine * velocity.x + sine * velocity.y;
      vTemp[0].y  = cosine * velocity.y - sine * velocity.x;
      vTemp[1].x  = cosine * other.velocity.x + sine * other.velocity.y;
      vTemp[1].y  = cosine * other.velocity.y - sine * other.velocity.x;

      /* Now that velocities are rotated, you can use 1D
       conservation of momentum equations to calculate 
       the final velocity along the x-axis. */
      PVector[] vFinal = {  
        new PVector(), new PVector()
      };

      // final rotated velocity for b[0]
      vFinal[0].x = ((m - other.m) * vTemp[0].x + 2 * other.m * vTemp[1].x) / (m + other.m);
      vFinal[0].y = vTemp[0].y;

      // final rotated velocity for b[0]
      vFinal[1].x = ((other.m - m) * vTemp[1].x + 2 * m * vTemp[0].x) / (m + other.m);
      vFinal[1].y = vTemp[1].y;

      // hack to avoid clumping
      bTemp[0].x += vFinal[0].x;
      bTemp[1].x += vFinal[1].x;

      /* Rotate ball positions and velocities back
       Reverse signs in trig expressions to rotate 
       in the opposite direction */
      // rotate balls
      PVector[] bFinal = { 
        new PVector(), new PVector()
      };

      bFinal[0].x = cosine * bTemp[0].x - sine * bTemp[0].y;
      bFinal[0].y = cosine * bTemp[0].y + sine * bTemp[0].x;
      bFinal[1].x = cosine * bTemp[1].x - sine * bTemp[1].y;
      bFinal[1].y = cosine * bTemp[1].y + sine * bTemp[1].x;

      // update balls to screen position
      other.position.x = position.x + bFinal[1].x;
      other.position.y = position.y + bFinal[1].y;

      position.add(bFinal[0]);

      // update velocities
      velocity.x = cosine * vFinal[0].x - sine * vFinal[0].y;
      velocity.y = cosine * vFinal[0].y + sine * vFinal[0].x;
      other.velocity.x = cosine * vFinal[1].x - sine * vFinal[1].y;
      other.velocity.y = cosine * vFinal[1].y + sine * vFinal[1].x;
    }
  }
  /* =====  COLLIDE METHODS END  ===== */
  
  
  /* ===== BURST START ===== */
  void burst() {    
    //create popping visual effect
    fill(255);
    ellipse(position.x, position.y, w*1.5, w*1.5);
    
    //choose a word
    int randomType = round(random(0,2)); //used to get a random position in the word type array
    String thisType = wordType[randomType]; //then create a variable to use that type to access the corresponsing array
    poem.write(thisType);
  }
  /* ===== BURST END ===== */

}
