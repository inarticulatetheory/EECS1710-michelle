//Adapted from Learning Processing patterns chapter

//use recirsion to draw increasingly small circles

void setup() {
  size(600,600);
}
//draws either a grid of rings or a band of circles

void draw() {
  background(255);
  stroke(0);
  noFill();
  //drawCircleBands(width/2, height/2, width/2);
  //or
  drawCircleRings(width/2, height/2, width/2);
}

void drawCircleBands(float x, float y, float radius) {
  ellipse(x, y, radius, radius);
  if (radius > 2) {
    //calling itself twice to create circle on left and right
    drawCircleBands(x + radius/2, y, radius/2);
    drawCircleBands(x - radius/2, y, radius/2);
  }
}

void drawCircleRings(float x, float y, float radius) {
  ellipse(x, y, radius, radius);
  if (radius > 8) {
    drawCircleRings(x + radius/2, y, radius/2);
    drawCircleRings(x - radius/2, y, radius/2);
    drawCircleRings(x, y + radius/2, radius/2);
    drawCircleRings(x, y - radius/2, radius/2);
  }
}
