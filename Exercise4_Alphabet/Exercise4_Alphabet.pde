/*
CODE CITED

1. Moving vector from https://processing.org/tutorials/pvector


*/

int horizon;
int landHeight;

//creature objects
Sealife[] sealife = new Sealife[100];

void setup() {
  size(800,600);
  horizon = height - height/3;
  landHeight = height/6; //100

  //initialize sealife array
  for (int i=0; i<sealife.length; i++) {
    sealife[i] = new Sealife();
  }
}

void draw() {
  background(255);
  
  rectMode(CORNER);

  //sky
  fill(200);
  rect(0, 0, width, horizon);
  
  //water
  fill(110);
  rect(0, horizon, width, height - horizon);
  
  //land
  fill(220);
  rect(50, horizon - landHeight, width, landHeight);
 
  //sealife functions for each object
  for (int i=0; i<sealife.length; i++) {
    sealife[i].admin();
    sealife[i].checkBoundaries();
    sealife[i].display();
  }
}
