// ADAPTED FROM: The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

// Crowd Path Following
// Via Reynolds: http://www.red3d.com/cwr/steer/CrowdPath.html

Path path;
ArrayList<Fish> fish;
Timer timer;
Bubbles[] bubbles;
int totalBubbles = 0; //start at 0 to access first element in array

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
  timer = new Timer(5000);
  timer.start();
}

void draw() {
  background(20, 50, 124);

  for (Fish f : fish) {
    // Path following and separation are worked on in this function
    f.applyBehaviors(fish,path);
    // Call the generic run method (update, borders, display, etc.)
    f.run();//pass a color
  }
  
  
  //check timer for bubbles
  if (timer.isFinished()) {
    //Set new bubble on timer completion
    //initializing array with variable
    bubbles[totalBubbles] = new Bubbles();
  
    //increment by one bubble every time draw() is run
    totalBubbles++;
  
    //if totalBubbles hits end of array, start over
    if (totalBubbles >= bubbles.length) {
      totalBubbles = 0;
    }
    
    timer.start(); //restart timer at current time
  } //timer end
  
  //display and move bubbles
  for (int i=0; i<totalBubbles; i++) {
    bubbles[i].move();
    bubbles[i].display();
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
