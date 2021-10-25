class Eye {
  
  /* ===== VARIABLES START ===== */
  //int eyeX, eyeY;
  int irisSize;
  int halfIris;
  int reflection;
  color irisColor;
  color eyeLidColor;
  color eyeWhiteColor;
  //global eye variables
  float eyecorner_x1;
  float eyecorner_y1;
  float eyecorner_x2; //tear duct
  float eyecorner_y2;
  float eyecorner_x3;
  float eyecorner_y3;
  
  float y;
  
  PVector position;
  ArrayList<Tears> tears;
  /* ===== VARIABLES END ===== */

  
  /* ===== CONSTRUCTOR START ===== */
  Eye(float x){
    irisSize = 20;
    halfIris = irisSize/2;
    reflection = halfIris/3;
    irisColor = color(157, 11, 126);
    eyeLidColor = color(252,148,230);
    eyeWhiteColor = color(255, 203, 244);
    
    y = irisSize + 10; //eye y value will always be static
    position = new PVector(x, y);
    tears = new ArrayList<Tears>();
  }
  /* ===== CONTRUCTOR END ===== */

  


/* ===== RUN EYE START ===== */
  void run() {
    draw();
    admin();
  }
/* ===== RUN EYE END ===== */


  /* ===== EYE ADMIN START ===== */
  void admin() {
    // remove all tears that are no longer alive
    for (int i=tears.size()-1; i>=0; i--) {
      Tears t = tears.get(i);
      if (t.active) {
        t.crying();
      } else {
        tears.remove(i);
      }
    }
  }
  /* ===== EYE ADMIN END ===== */


  /* ===== CRY START ===== */
  void cry() {
    tears.add(new Tears(position.x, position.y));
  }
  /* ===== CRY END ===== */
  
  
  /* ===== EYE DRAW START ===== */
  void draw() {
    position.x = mouseX;

    ellipseMode(CENTER);
    rectMode(CENTER);

    //set eye coordinates
    eyecorner_x1 = position.x + (irisSize*2.5)/2; //edge of eye white
    eyecorner_y1 = position.y - (halfIris/2);
    eyecorner_x2 = eyecorner_x1 + halfIris/2;
    eyecorner_y2 = position.y + irisSize/3;
    eyecorner_x3 = position.x + halfIris;
    eyecorner_y3 = position.y + halfIris;
    
    //eye white
    noStroke();
    
    fill(eyeLidColor);
    rect(position.x, position.y, irisSize*2.5, irisSize*1.5, 30, 30, 80, 80);
    
    fill(eyeWhiteColor);
    rect(position.x, position.y, irisSize*2.5, irisSize, 30, 30, 80, 80);
    triangle(eyecorner_x1, eyecorner_y1, eyecorner_x2, eyecorner_y2, eyecorner_x3, eyecorner_y3); 
    
    //tear duct
    fill(150,0,90); //darker
    ellipse(eyecorner_x2,eyecorner_y2, reflection, reflection);

    //iris
    fill(irisColor);
    ellipse(position.x, position.y, irisSize, irisSize);
    
    //pupil
    fill(0);
    ellipse(position.x, position.y, halfIris, halfIris);
    
    //reflection
    fill(255);
    ellipse(position.x-reflection, position.y-reflection, reflection, reflection);
    
    //top eyelid
    fill(252,148,230);
    arc(position.x + 1, position.y-halfIris/3, irisSize*2.5 + 4, irisSize*1.5, radians(190), radians(360), CHORD);
  }
  /* ===== EYE DRAW END ===== */
}
