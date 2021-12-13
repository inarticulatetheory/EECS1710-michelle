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


void setup() {
  size(1200, 600, P3D);
  frameRate(120);
  
  setupNoise();
  setupNotes();
  setupWaveform();
  setupFaceDetection();
  setupOrbitingLight(); //updated in Faces
  
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


  for (int i = 0; i < stars.length; i++) {
    stars[i].update();
    stars[i].display();
  }
  for (int i = 0; i < comets.length; i++) {
    comets[i].update();
    comets[i].display();
  }
}
