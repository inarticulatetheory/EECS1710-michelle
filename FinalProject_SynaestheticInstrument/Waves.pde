/**
 * CODE CITED:
 * Processing Sound Library, Example 1
 *
 * Five sine waves are layered to construct a cluster of frequencies.
 * This method is called additive synthesis. Use the mouse position
 * inside the display window to detune the cluster.
 */
import processing.sound.*;

SinOsc[] sineWaves; // Array of sines
float[] sineFreq; // Array of frequencies
int numSines = 5; // Number of oscillators to use

void setupWaves() {
  sineWaves = new SinOsc[numSines]; // Initialize the oscillators
  sineFreq = new float[numSines]; // Initialize array for Frequencies

  for (int i = 0; i < numSines; i++) {
    // Calculate the amplitude for each oscillator
    float sineVolume = (1.0 / numSines) / (i + 1);
    // Create the oscillators
    sineWaves[i] = new SinOsc(this);
    // Start Oscillators
    sineWaves[i].play();
    // Set the amplitudes for all oscillators
    sineWaves[i].amp(sineVolume);
  }
}

void updateWaves(float x_, float y_, float w_, float h_) {
  float x = x_;
  float y = y_;
  float w = w_;
  float h = h_;

  
  //Map y from 0 to 1
  float yoffset = map(y, 0+h, height-h, 0, 1);
  //Map y logarithmically to 150 - 1150 to create a base frequency range
  float frequency = pow(1000, yoffset) + 150;
  //Use width of face mapped from -0.5 to 0.5 as a detune argument
  float detune = map(w, 0, height, -0.5, 0.5);

  for (int i = 0; i < numSines; i++) {
    sineFreq[i] = frequency * (i + 1 * detune);
    // Set the frequencies for all oscillators
    sineWaves[i].freq(sineFreq[i]);
  }
}
