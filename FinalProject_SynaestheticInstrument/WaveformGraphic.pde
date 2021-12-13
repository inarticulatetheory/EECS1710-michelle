/**
 * CODE CITED: Processing Examples > Sound > Waveform
 * This sketch shows how to use the Waveform class to analyze a stream
 * of sound. Change the number of samples to extract and draw a longer/shorter
 * part of the waveform.
 */

import processing.sound.*;

AudioIn mic;
Waveform waveform;

int samples = 100; // how many samples of the Waveform to read at once

void setupWaveform() {  
  //start listening to microphone
  mic = new AudioIn(this, 0);
  mic.start();
  
  // Create the Waveform analyzer and connect the playing soundfile to it.
  waveform = new Waveform(this, samples);
  waveform.input(mic);
}

void updateWaveform() {
  
  // Perform the analysis
  waveform.analyze();
  stroke(250, 249, 220, 130);
  strokeWeight(2);
  noFill();
  beginShape();
  for(int i = 0; i < samples; i++){
    // Draw current data of the waveform
    // Each sample in the data array is between -1 and +1 
    vertex(
      map(i, 0, samples, 0, width),
      map(waveform.data[i], -1, 1, 0, height)
    );
    //pass this same point (a, b) to the path
    path.addPoint(map(i, 0, samples, 0, width),map(waveform.data[i], -1, 1, 0, height));
  }
  endShape();


}
