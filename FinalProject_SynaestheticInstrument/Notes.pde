/* Code adapted from Processing Examples > Sound > Env > Envelopes */

import processing.sound.*;

SinOsc osc;
Env env;

int[] midiSequence = { 60, 61, 62, 63, 64, 65, 66, 67, 68, 69, 70, 71, 72 }; // This is an octave in MIDI notes.
int trigger; 
int note;
int duration;

// Times and levels for the ASR envelope
float attackTime = 0.001;
float sustainTime = 0.004;
float sustainLevel = 0.3;
float releaseTime = 0.2;

void setupNotes() {
  osc = new SinOsc(this); // Create a wave and start it;
  env = new Env(this); // Create the envelope 
  
  duration = 200; // Play a new note every 200ms
  trigger = millis(); // This variable stores the point in time when the next note should be triggered
  note = 0; // An index to count up the notes
}

void updateNotes() {
// If the determined trigger moment in time matches up with the computer clock and
  // the sequence of notes hasn't been finished yet, the next note gets played.
  if ((millis() > trigger) && (note<midiSequence.length)) {

    // midiToFreq transforms the MIDI value into a frequency in Hz which we use to
    // control the triangle oscillator with an amplitute of 0.5
    osc.play(midiToFreq(midiSequence[note]), 0.5);

    // The envelope gets triggered with the oscillator as input and the times and
    // levels we defined earlier
    env.play(osc, attackTime, sustainTime, sustainLevel, releaseTime);

    // Create the new trigger according to predefined duration
    trigger = millis() + duration;

    // Advance by one note in the midiSequence;
    note++; 

    // Loop the sequence, notice the jitter
    if (note == 12) {
      note = 0;
    }
  }
} 

// This helper function calculates the respective frequency of a MIDI note
float midiToFreq(int note) {
  return (pow(2, ((note-69)/12.0))) * 440;
}
