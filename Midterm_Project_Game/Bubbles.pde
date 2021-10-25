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
  
  //poetry variables
  String thisType; //indicates the word type: noun, adj, verb
  


  /* ===== VARIABLES END ===== */
  
  /* ===== CONSTRUCTOR START ===== */
  Bubbles(float x, float y, float _w) {    
    position = new PVector(x, y); 
    velocity = PVector.random2D();
    velocity.mult(2);
    w = _w;
    radius = w/2;
    m = radius * 0.1;
    
    //used for collision detection since position variables are also PVectors
    bubbleSize = new PVector(w, w);  
    
    //assign a word type
    int randomType = round(random(0,2)); //used to get a random position in the word type array
    thisType = wordType[randomType]; //then create a variable to use that type to access the corresponsing array
  
    //use for fill
    if (thisType == "noun"){
      bubbleColor = color(121, 255, 167); //lime green
    } else if (thisType == "adjective") {
      bubbleColor = color(211, 197, 229); //soft purple
    } else if (thisType == "verb") {
      bubbleColor = color(255, 242, 121); //pale yellow
    } 
  }
  /* ===== CONSTRUCTOR END ===== */
  
  
  /* ===== RUN BUBBLES START ===== */
  void run() {
    admin();
    draw();
    checkBoundaryCollision(); //keeps bubbles in canvas
  }
  /* ===== RUN BUBBLES END ===== */
  
  /* ===== ADMIN START ===== */
  void admin(){  
    
    //move around
    position.add(velocity);
       
    //check for collision with tear
    for (Tears t : eye.tears) {
      if (active && tempHitDetection(position, t.position, bubbleSize)) {
        active = false;
        burst();
      }
    }
    
    //add to constellation when burst
    constellation();
  }
  /* ===== ADMIN END ===== */

  
  /* ===== DRAW BUBBLES START ===== */
  void draw() {    
    //draw bubble
    fill(bubbleColor, 120); //apply 80 alpha
    ellipseMode(CENTER);
    ellipse(position.x, position.y, w, w);
        
    //draw reflection
    fill(255, 80);
    quad(position.x - w/4, position.y, position.x - w/3, position.y, position.x - w/3, position.y - w/4, position.x - w/6, position.y - w/3);
    
    //add text for word type
    fill(255);
    textSize(16);
    text(thisType.toUpperCase(),position.x, position.y + 5);
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
    fill(bubbleColor);
    ellipse(position.x, position.y, w*1.5, w*1.5);
    
   poem.write(thisType);
  }
  /* ===== BURST END ===== */
  
  
  /* ===== POETRY CONSTELLATION ===== */
  void constellation() {
    //POETRY CONSTELLATION
    // We must keep track of our position along the curve
    float arclength = 0;
    
    if (poetryConstellation.length() > 1) { //make sure there's at least one word
      for (int i = 0; i < poetryConstellation.length(); i++) {
        // Instead of a constant width, we check the width of each character.
        char currentChar = poetryConstellation.charAt(i);
        float w = textWidth(currentChar);
    
        // Each box is centered so we move half the width
        arclength += w/2;
        // Angle in radians is the arclength divided by the radius
        // Starting on the left side of the circle by adding PI
        float theta = PI + arclength / radius;
    
        pushMatrix();
        // Polar to cartesian coordinate conversion
        translate(radius*cos(theta), radius*sin(theta));
        // Rotate the box
        rotate(theta+PI/2); // rotation is offset by 90 degrees
        // Display the character
        fill(255,150);
        textSize(12);
        text(currentChar,position.x,position.y); //was posX, posY
        popMatrix();
        // Move halfway again
        arclength += w/2;
        }
      }
    }
    /* ===== POETRY CONSTELLATION END ===== */


}
