// ADAPTED FROM: The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

// Crowd Path Following
// Via Reynolds: http://www.red3d.com/cwr/steer/CrowdPath.html

// Using this variable to decide whether to draw all the stuff
boolean debug = false;


// A path object (series of connected points)
Path path;

// Two vehicles
ArrayList<Vehicle> vehicles;

void setup() {
  size(800,600);
  // Call a function to generate new Path object
  newPath();

  // We are now making random vehicles and storing them in an ArrayList
  vehicles = new ArrayList<Vehicle>();
  for (int i = 0; i < 120; i++) {
    newVehicle(random(width),random(height));
  }
}

void draw() {
  background(255);
  // Display the path FOR DEBUGGING
  //path.display();

  for (Vehicle v : vehicles) {
    // Path following and separation are worked on in this function
    v.applyBehaviors(vehicles,path);
    // Call the generic run method (update, borders, display, etc.)
    v.run();
  }

  // Instructions
  fill(0);
  textAlign(CENTER);
  text("Hit 'd' to toggle debugging lines.\nClick the mouse to generate new vehicles.",width/2,height-20);
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

void newVehicle(float x, float y) {
  float maxspeed = random(2,4);
  float maxforce = 0.3;
  vehicles.add(new Vehicle(new PVector(x,y),maxspeed,maxforce));
}

void keyPressed() {
  if (key == 'd') {
    debug = !debug;
  }
}

void mousePressed() {
  newVehicle(mouseX,mouseY);
}
