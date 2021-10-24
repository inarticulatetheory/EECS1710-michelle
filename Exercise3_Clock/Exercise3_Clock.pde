float hMiddle;
float leftQuartile;
float rightQuartile;

float vMiddle;
float topQuartile;
float bottomQuartile;

//breathing positions
//adapted from Learning Processing Lesson 4, Ex 9.8 Snake Game
float[] xpos = new float[50];
float[] ypos = new float[50];

//breathing speed
float xspeed = 0.4;
float yspeed = 1;

//breathing time
int savedTime;
int oneBreath = 3000; //3 seconds per breath


void setup() {
 size(1200,600);
 
  //split screen quadrants - VERTICAL SPLIT
  vMiddle = width/2;
  leftQuartile = vMiddle/2;
  rightQuartile = width - leftQuartile;
 
  //split screen quadrants - HORIZONTAL SPLIT
  hMiddle = height/2;
  topQuartile = hMiddle/2;
  bottomQuartile = height - topQuartile;
  
  //initialize array by setting all positions to start
  for (int i=0; i<xpos.length; i++){
    xpos[i] = vMiddle;
    ypos[i] = height;
  }
  
  savedTime = millis();

}

void draw() {
  background(255);
  
  //split screen - HORIZONTAL
  stroke(160);
  line(0, topQuartile, width, topQuartile);
  stroke(180);
  line(0, hMiddle, width, hMiddle);
  stroke(200);
  line(0, bottomQuartile, width, bottomQuartile);
  
  //split screen - VERTICAL
  stroke(50);
  line(leftQuartile, 0, leftQuartile, height);
  stroke(90);
  line(vMiddle, 0, vMiddle, height);
  stroke(130);
  line(rightQuartile, 0, rightQuartile, height);

  
  //face
  noStroke();
  
  /* NOSE */
  fill(100);  
  triangle(leftQuartile, bottomQuartile, leftQuartile + (leftQuartile/2), 0, vMiddle, bottomQuartile);
  fill(90);
  arc(leftQuartile + (leftQuartile/2), bottomQuartile,leftQuartile, topQuartile, radians(180), radians(360));
  arc(leftQuartile + (leftQuartile/2), bottomQuartile,leftQuartile, topQuartile/3, radians(0), radians(180));

  ellipseMode(CENTER);
  ellipse(leftQuartile + (leftQuartile/2), bottomQuartile, leftQuartile/3, leftQuartile/4);
  //nostrils
  fill(60);
  ellipse(leftQuartile + (leftQuartile/4), bottomQuartile, leftQuartile/4, leftQuartile/8);
  ellipse(vMiddle - (leftQuartile/4), bottomQuartile, leftQuartile/4, leftQuartile/8);
  
  breatheIn(); //take a new breath
  /* Timer adapted from Learning Processing Chapter 10, Ex 10.4 */
  // Calculate how much time has passed
  int passedTime = millis() - savedTime;
  if (passedTime > oneBreath) {
      savedTime = millis(); // Save the current time to restart the timer!
      breatheIn(); //take a new breath
  }


}

void breatheIn() {
  float breatheStartX;
  float breatheStartY;
  float breatheEndX;
  float breatheEndY;
  
  float time = 1;
  

  
  //shift array down to make room for new coordinates
  //skip last position though
  for (int i=0; i<xpos.length - 1; i++) {
    xpos[i] = xpos[i + 1];
    ypos[i] = ypos[i + 1];
  }
  

  
  //set last position of array to newest position
  xpos[xpos.length - 1] = xpos[xpos.length - 2] - xspeed;
  ypos[ypos.length - 1] = ypos[ypos.length - 2] - yspeed;
  
  //draw circle based on history of locations
  for (int i=0; i<xpos.length; i++) {
    noStroke();
    fill(222 - i * 3, 74, 190, i*2);
    ellipse(xpos[i], ypos[i], 40, 40);
    
    if (xpos[i] < (leftQuartile + leftQuartile / 2)) {
      xpos[i] = leftQuartile + leftQuartile / 2;
    }
    if (ypos[i] < 0) {
      ypos[i] = -100;
    }
  }
}
