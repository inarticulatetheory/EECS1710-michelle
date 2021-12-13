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
float[] sineVolume; // array of amplitudes
Delay delay;

int numSines = 3; // Number of oscillators to use
float x, y, w, h, z;

void setupNoise() {
  sineWaves = new SinOsc[numSines]; // Initialize the oscillators
  sineVolume = new float[numSines]; 
  //sineFreq = new float[numSines]; // Initialize array for Frequencies
  delay = new Delay(this);

  // Connect the soundfile to the delay unit, which is initiated with a
  // five second "tape"
  //delay.process(this, 5.0);
  
  for (int i = 0; i < numSines; i++) {
    // Calculate the amplitude for each oscillator
    // The overall amplitude shouldn't exceed 1.0 which is prevented by 1.0/numSines.
    // The ascending waves will get lower in volume the higher the frequency.
    sineVolume[i] = (1.0 / numSines) / (i + 1);
    
    // Create and start the oscillators
    sineWaves[i] = new SinOsc(this); //create
    sineWaves[i].play(); //start
    /*
    // Set the amplitudes for all oscillators
    sineWaves[i].amp(sineVolume);
    */
  }
}

void updateNoise(float x_, float y_, float w_, float h_, float z_) {
  x = x_;
  y = y_;
  w = w_;
  h = h_;
  z = z_;

  
  //Map y from 0 to 1 
  //removing height (h) since face recognition would drop off if face not fully on canvas
  float yoffset = map(y, 0+h, height-h, 0, 1);
  
  //Map that y value logarithmically to 150 - 1150 Hz to create a base frequency range
  float frequency = pow(1000, yoffset) + 150;
  
  //Use x of face mapped from -0.5 to 0.5 as a detune argument
  //removing width (w) since face recognition would drop off if face not fully on canvas
  float detune = map(x, 0+w, width-w, -0.5, 0.5);

  //Set frequencies, detuning, volume
  for (int i = 0; i < numSines; i++) {
    sineWaves[i].freq(frequency * (i + 1 * detune));
    sineWaves[i].amp(sineVolume[i]);
  }
  
  // Delay Feedback --> Map z from 0 to 0.8
  float fb = map(z, 0, width, 0.0, 0.8);
  delay.feedback(fb);
  // Length of Delay --> Map z from 0.001 to 2.0 seconds for the length of the delay
  float delayTime = map(z, 0, width, 0.001, 2.0);
  delay.time(delayTime);
}
