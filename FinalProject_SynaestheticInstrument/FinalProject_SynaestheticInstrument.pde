//maybe shape of mouth is note
//sound could move an image forward
//placement on screen is reverb or something

/* CODE CITED
1 - Base sound functionality adapted from Processing Sound Library, Example 1
    https://processing.org/tutorials/sound
*/


import processing.sound.*;

void setup() {
  size(640, 360);
  background(255);
  setupWaves();
}

void draw() {
  updateWaves();
}
