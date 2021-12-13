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
*/

import processing.sound.*;

// Two vehicles
//ArrayList<Vehicle> vehicles;
boolean debug = false;

void setup() {
  size(1200, 600, P3D);
  frameRate(90);
  
  setupNoise();
  setupNotes();
  setupWaveform();
  setupPath();
  setupFaceDetection();
  setupOrbitingLight(); //updated in Faces
}

void draw() {
  background(7, 12, 21);
  
  updateNotes();
  updateWaveform();
  updatePath();
  updateFaceDetection();
  //updateOrbitingLight();
  
  /*
  for (Vehicle v : vehicles) {
    // Path following and separation are worked on in this function
    v.applyBehaviors(vehicles,path);
    // Call the generic run method (update, borders, display, etc.)
    v.run();
  }
  */

}
