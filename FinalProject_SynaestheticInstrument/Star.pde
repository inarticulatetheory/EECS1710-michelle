/* CODE CITED: THe Coding Train Starfield Example 
* https://github.com/CodingTrain/website/blob/main/CodingChallenges/CC_001_StarField/Processing/CC_001_StarField/Star.pde
*/

class Star {
  float x;
  float y;
  float z;
  float pz;
  float speed;
  
  Star() {
    // I place values in the variables
    x = random(-width/2, width/2);
    // note: height and width are the same: the canvas is a square.
    y = random(-height/2, height/2);
    // note: the z value can't exceed the width/2 (and height/2) value,
    // beacuse I'll use "z" as divisor of the "x" and "y",
    // whose values are also between "0" and "width/2".
    z = random(width/2);
    speed = random(1, 4);
    pz = z; //previous location
  }
  
  void update() {
    z = z - speed;
    if (z < 1){
      z = width/2;
      x = random(-width/2, width/2);
      y = random(-height/2, height/2);
      pz = z;
    }
  
  }
  
  void display() {
    //pushMatrix();
    //translate to center of window to draw
    translate(0, 0, 0);
      fill(255, 200);
      noStroke();
      float sx = map(x/z, 0, 1, 0, width/2);
      float sy = map(y/z, 0, 1, 0, height/2);
      
      float r = map(z, 0, width/2, 3, 0);
      ellipse(sx, sy, r, r);
    //popMatrix();
  }
}
