/*
CODE CITED

1. Moving vector from https://processing.org/tutorials/pvector
2. Timer from processing.org timer example

*/

int horizon;
int landHeight;

Timer timer;

Sealife[] sealife = new Sealife[100];
int totalSealife = 0; //start at 0 to access first element in array


void setup() {
  size(800,600);
  horizon = height - height/3;
  landHeight = height/6; //100
  
  //set up timer
  timer = new Timer(500);
  timer.start();
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
  
  //check timer before sending another sea creature
  if (timer.isFinished()) {
    sealife[totalSealife] = new Sealife();
    
    totalSealife++; //increment to create next position in array on next timer end
    
    //if totalSealife hits end of array, start over
    if (totalSealife >= sealife.length) {
      totalSealife = 0;
    }
    
    timer.start(); //restart timer at current time
    }
 
  //sealife functions for each object
  for (int i=0; i<totalSealife; i++) {
    sealife[i].admin();
    sealife[i].checkBoundaries();
    sealife[i].display();
  }
}
