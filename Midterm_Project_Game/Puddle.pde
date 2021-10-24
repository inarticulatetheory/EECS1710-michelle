/* Puddle will grow as tears hit the bottom */

class Puddle {
  /* ===== VARIABLES START ===== */
  color puddleColor = color(188, 233, 255);
  /* ===== VARIABLES END ===== */

  
  /* ===== CONSTRUCTOR START ===== */
  Puddle() {
  }
  /* ===== CONSTRUCTOR END ===== */
  
  
  /* ===== DRAW START ===== */
  void draw() {
    rectMode(CENTER);
    fill(puddleColor);
    rect(width/2, height - tide/2, width, tide);
  }
  /* ===== DRAW END ===== */
}
