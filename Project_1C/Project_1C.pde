/* 
Michelle Lemay

CODE CITED:
- Set Gradient code sourced from https://processing.org/examples/lineargradient.html
- Timer sourced from _Learning Processing_ by Daniel Schiff, Chapter 10
- constraining a shape to a certain boundary adapted from _Learning Processing_ by Daniel Schiff, Chapter 1
*/

/* VARIABLES */
Firefly[] fireflies = new Firefly[60];

//boundary variables
float topBoundary;
float bottomBoundary;
float leftBoundary;
float rightBoundary;

//variables for background
color c1 = color(19, 48, 35);
color c2 = color(0); //color(67, 40, 41);

void setup() {
  size(600, 600);
  for (int i=0; i<fireflies.length; i++) {
    //Firefly(x location, y location, width, xspeed, yspeed, will die)
    fireflies[i] = new Firefly(random(100,500), random(100,500), random(5,20), random(-4,4), random(-4,4), int(random(1,5)));
  }
}

void draw() {

    
  noStroke();
  background(255);
  rectMode(CENTER);

  /* === BEGIN DRAWING "STATIC" ELEMENTS === */
    //DRAW TABLE
      noStroke();
      fill(62, 37, 37);
      rect(width/2, height - 60, width, height/5);
      
      //WOOD GRAIN
      stroke(230, 158, 62, 30);
      strokeWeight(1);
      for (int i=(height/5); i>0; i--) {
        ellipse(0, height, i + i * 0.5, i * 0.9);
        ellipse(100,height - height/5 + 15, i + i, i);
        ellipse(width/2, height, i * 3, i);
        ellipse(500, 500, i * 2, i);
        ellipse(width, height, i * 1.15, i * 0.7);
        i = i - 5;
      }
      
  //DRAW BACKGROUND
    setGradient(0, 0, width, height - height/5, c1, c2);
    
  /* === DRAW JAR === */
    //inside of jar
    noStroke();
    fill(243, 183, 169, 80);

    rect(width/2, height/2 + 15, 400, 470, 80, 80, 44, 44); //inner body of jar
    fill(129, 95, 92);
    ellipse(width/2, height - 67, 370, 74); //bottom inside of jar
  /* === END DRAWING JAR === */
  
  for (int i=0; i<fireflies.length; i++) {
    fireflies[i].display();
    fireflies[i].fly();
  }
    
    /* DRAW LID */
    //Lid must be on top layer of fireflies for "realistic" visual
    
    /* BOTTOM OF LID */
    ellipseMode(CENTER);
    noStroke();
    fill(35);
    rect(width/2, 80, 350, 30, 15); // bottom of lid
    arc(width/2, 85, 350, 60, radians(6), radians(170)); //bottom of lid
    
    /* MIDDLE OF LID */
    fill(48);
    ellipse(width/2, 30, 380, 60);
    rect(width/2, 50, 380, 60, 15);
    ellipse(width/2, 70, 380, 60);
    
    /* BANDS OF MIDDLE OF LID */
    stroke(65);
    strokeWeight(3);
    arc(width/2, 60, 375, 60, 0, PI+HALF_PI);
    stroke(60);
    arc(width/2, 50, 375, 60, 0, PI+HALF_PI);
    stroke(65);
    arc(width/2, 40, 375, 60, 0, PI);

    /* TOP OF LID */
    noStroke();
    fill(58);
    ellipse(width/2, 32, 370, 55); //top of lid
    fill(68);
    ellipse(width/2, 32, 330, 35); //top of lid
    /* END DRAWING LID */
    
    //shine
    stroke(240, 183, 170, 20);
    strokeWeight(25);
    noFill();
    arc(width/2, 130, 380, 80, radians(12), radians(170));
    
    noStroke();
    fill(240, 183, 170, 20);
    rect(width/4, height/2, 95, 230, 5, 80, 25, 5);

} 

  
/* Set Gradient code sourced from https://processing.org/examples/lineargradient.html */
void setGradient(int x, int y, float w, float h, color c1, color c2) {
  noFill();
  
  for (int i = y; i <= y+h; i++) {
    float inter = map(i, y, y+h, 0, 1);
    color c = lerpColor(c1, c2, inter);
    stroke(c);
    line(x, i, x+w, i);
  }
}
