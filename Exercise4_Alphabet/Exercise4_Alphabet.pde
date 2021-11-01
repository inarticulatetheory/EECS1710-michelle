// ADAPTED FROM: The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

// Crowd Path Following
// Via Reynolds: http://www.red3d.com/cwr/steer/CrowdPath.html

Path path;
ArrayList<Fish> fish;
Timer bubbleTimer, backgroundTimer; //timer for different elements
Bubbles[] bubbles;
BackgroundLife[] backgroundlife;

int totalBubbles = 0; //start at 0 to access first element in array
int totalLife = 0; //start at 0 to access first element in array

//variables for background gradient
color c1 = color(15, 28, 90);
color c2 = color(0); //color(67, 40, 41);


void setup() {
  size(800,600);
  // Call a function to generate new Path object
  newPath();

  // We are now making random vehicles and storing them in an ArrayList
  fish = new ArrayList<Fish>();
  for (int i = 0; i < 190; i++) {
    newFish(random(width),random(height));
  }
  
  bubbles = new Bubbles[200];
  backgroundlife = new BackgroundLife[40];
  bubbleTimer = new Timer(500);
  bubbleTimer.start();
  backgroundTimer = new Timer(2000);
  backgroundTimer.start();
}

void draw() {
  background(15, 28, 90);
  
  //DRAW GRADIENT
  setGradient(0, 0, width, height, c1, c2);
  
  for (Fish f : fish) {
    // Path following and separation are worked on in this function
    f.applyBehaviors(fish,path);
    // Call the generic run method (update, borders, display, etc.)
    f.run();//pass a color
  }
  
  
  //check timer for bubbles
  if (bubbleTimer.isFinished()) {
    //Set new bubble life on timer completion
    //initializing array with variable
    bubbles[totalBubbles] = new Bubbles();
  
    //increment by one bubble every time draw() is run
    totalBubbles++;
  
    //if totalBubbles hits end of array, start over
    if (totalBubbles >= bubbles.length) {
      totalBubbles = 0;
    }
    
    bubbleTimer.start(); //restart timer at current time
  } //timer end
  
    //check timer for background life
  if (backgroundTimer.isFinished()) {
    //Set new background life on timer completion
    //initializing array with variable
    backgroundlife[totalLife] = new BackgroundLife();
  
    //increment by one every time draw() is run
    totalLife++;

    //if totalLife hits end of array, start over
    if (totalLife >= backgroundlife.length) {
      totalLife = 0;
    }
    
    backgroundTimer.start(); //restart timer at current time
  } //timer end
  
  //display and move bubbles
  for (int i=0; i<totalBubbles; i++) {
    bubbles[i].move();
    bubbles[i].display();
  }
  
  //display and move background life
  for (int i=0; i<totalLife; i++) {
    backgroundlife[i].move();
    backgroundlife[i].display();
  }
}

void newPath() {
  // A path is a series of connected points
  // A more sophisticated path might be a curve
  path = new Path();
  float offset = 30;
  //'A' path
  //Needs to go offscreen to complete a loop
  path.addPoint(width/3,height/2); //middle-left
  path.addPoint(width/2,offset); //top
  path.addPoint(width - width/3,height/2); //middle-right, redundant but just to have
  path.addPoint(width - offset*3,height - offset); //bottom-right
  path.addPoint(width - offset*3,height + offset); //offscreen, bottom-right
  path.addPoint(offset*3,height + offset); //offscreen, bottom-left
  path.addPoint(offset*3,height-offset); //bottom-left
  path.addPoint(width/3,height/2); //middle-left
  path.addPoint(width/2, height/2); //middle
  path.addPoint(width - width/3,height/2); //middle-right, redundant but just to have

}

void newFish(float x, float y) {
  float maxspeed = random(2,4);
  float maxforce = 0.3;
  fish.add(new Fish(new PVector(x,y),maxspeed,maxforce, color (255,random(160,255),10)));
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
