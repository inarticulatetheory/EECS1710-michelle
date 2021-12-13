//maybe shape of mouth is note
//sound could move an image forward
//placement on screen is reverb or something

/* CODE CITED
"adapted" code used as a starting point and developed off of
1 - Base sound functionality adapted from Processing Sound Library, Example 1
    https://processing.org/tutorials/sound
2 - Waveform graphic adapted from Processing Examples > Sound > Waveform
3 - Face Detection adapted from Processing Examples > OpenCV > FaceDetection
4 - Moon texture from http://planetpixelemporium.com/
5 - "Notes" code adapted from Processing Examples > Sound > Env > Envelopes
6 - The Nature of Code by Daniel Shiffman Path Following
7 - The Coding Train "Starfield" example - https://github.com/CodingTrain/website/blob/main/CodingChallenges/CC_001_StarField

*/

import processing.sound.*;

Star[] stars = new Star[800];
Comet[] comets = new Comet[50];
Path path;
ArrayList<CelestialBodies> celestialBodies;


void setup() {
  size(1200, 600, P3D);
  frameRate(120);
  
  setupNoise();
  setupNotes();
  setupWaveform();
  setupFaceDetection();
  setupOrbitingLight(); //updated in Faces
  
  // Call a function to generate new Path object
  newPath();
  // Then making random "vehicles" (here, celestialBodies) and store them in an ArrayList
  celestialBodies = new ArrayList<CelestialBodies>();
  for (int i = 0; i < 190; i++) {
    pushMatrix();
    //translate to center of window to draw
      translate(-width/2, -height/2, -width);
      newCelestialBody(random(width),random(height),random(width));
    popMatrix();
  }
  
  //background stars and comets
  for (int i = 0; i < stars.length; i++) {
    stars[i] = new Star();
  }
  for (int i = 0; i < comets.length; i++) {
    comets[i] = new Comet();
  }
  
}

void draw() {
  background(7, 12, 21);
  
  updateNotes();
  updateWaveform();
  updateFaceDetection();
  updateOrbitingLight();

  for (CelestialBodies cb : celestialBodies) {
    // Path following and separation are worked on in this function
    cb.applyBehaviors(celestialBodies,path);
    // Call the generic run method (update, borders, display, etc.)
    cb.run();
  }

  for (int i = 0; i < stars.length; i++) {
    stars[i].update();
    stars[i].display();
  }
  for (int i = 0; i < comets.length; i++) {
    comets[i].update();
    comets[i].display();
  }
}

/* FUNCTIONS FOR NEW ITEMS */
void newPath() {
  // A path is a series of connected points
  // A more sophisticated path might be a curve
  path = new Path();
  float offset = 30;
  //'A' path
  //Needs to go offscreen to complete a loop
  //path.addPoint(0 - offset,height/2); //left
  //path.addPoint(width/2,height/2); //middle
  //path.addPoint(width + offset,height/2); //right

}

void newCelestialBody(float x, float y, float z) {
  float maxspeed = random(2,4);
  float maxforce = 0.3;
  celestialBodies.add(new CelestialBodies(new PVector(x,y,z),maxspeed,maxforce));
}
