/*
CODE CITED
1. Moving vector from https://processing.org/tutorials/pvector
2. Timer from processing.org timer example
3. Moving sealife to another point is from 
   Flocking example at https://processing.org/examples/flocking.html
*/

int horizon;
int landHeight;
PVector position1, position2;
boolean ready = false;

Timer timer;

//Sealife[] sealife = new Sealife[100];
int totalSealife = 0; //start at 0 to access first element in array

Flock flock;


void setup() {
  size(800,600);
  horizon = height - height/3;
  landHeight = height/6; //100
  
  //set up timer
  timer = new Timer(500);
  timer.start();
  
    position1 = new PVector(width/2, height/2);
    position2 = new PVector(width - width/3, height - height/3);
    
  flock = new Flock();
  //initial flock
  for (int i=0; i<50; i++) {
    flock.addLife(new Life(width/2,height/2));
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
  
  flock.run();
  
  //check timer before sending another sea creature
  if (timer.isFinished()) {
    ready = true;
    flock.addLife(new Life(random(width), random(height)));
    //sealife[totalSealife] = new Sealife();    
    
    /* TRYING OUT MODULO
    This is the same as
      totalSealife++; //increment to create next position in array on next timer end
      if (totalSealife >= sealife.length) {
        totalSealife = 0;
      }
    */
    //if totalSealife hits end of array, start over
    //totalSealife = (totalSealife + 1) % sealife.length; 

    timer.start(); //restart timer at current time
    }
 
  //sealife functions for each object
  /*
  for (int i=0; i<totalSealife; i++) {
    sealife[i].admin();
    sealife[i].checkBoundaries();
    sealife[i].display();
  }
  */
}
