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
  
  setupNoise();
  setupNotes();
  setupWaveform();
  setupFaceDetection();  
  // Call a function to generate new Path object
  newPath();
  // Then making random "vehicles" (here, celestialBodies) and store them in an ArrayList
  celestialBodies = new ArrayList<CelestialBodies>();
  for (int i = 0; i < 190; i++) {
    pushMatrix();
      translate(0, 0, 0);
      newCelestialBody(random(width),random(height),random(200));
      
      //trigger a new note sequence
      //trigger = true; WENT BACK ON THIS
    popMatrix();
  }
  
  //background stars and comets
  for (int i = 0; i < stars.length; i++) {
    stars[i] = new Star();
  }
  for (int i = 0; i < comets.length; i++) {
    comets[i] = new Comet();
  }
  
  frameRate(60);
}

void draw() {
  background(7, 12, 21);
  
  updateNotes();
  updateWaveform();
  setupLight();
  updateFaceDetection();

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
}

void newCelestialBody(float x, float y, float z) {
  float maxspeed = random(2,4);
  float maxforce = 0.3;
  celestialBodies.add(new CelestialBodies(new PVector(x,y,z),maxspeed,maxforce));
}
