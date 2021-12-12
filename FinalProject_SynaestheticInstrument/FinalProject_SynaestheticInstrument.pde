//maybe shape of mouth is note
//sound could move an image forward
//placement on screen is reverb or something

/* CODE CITED
"adapted" code used as a starting point and developed off of
1 - Base sound functionality adapted from Processing Sound Library, Example 1
    https://processing.org/tutorials/sound
2 - Waveform graphic adapted from Processing Examples > Sound > Waveform
3 - Face Detection adapted from Processing Examples > OpenCV > FaceDetection
*/


import processing.sound.*;

void setup() {
  size(640, 360);
  setupWaves();
  setupWaveform();
  setupFaceDetection();
}

void draw() {
  background(7, 12, 21);

  //updateWaves();
  updateWaveform();
  updateFaceDetection();
}
