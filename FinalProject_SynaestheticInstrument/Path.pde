/*
 * CODE CITED: 
 * Processing Examples > Sound > Waveform
 * The Nature of Code by Daniel Shiffman Path Following
 * This sketch shows how to use the Waveform class to analyze a stream
 * of sound. Change the number of samples to extract and draw a longer/shorter
 * part of the waveform.
 */
 

ArrayList<PVector> points; // A Path is an arraylist of points (PVector objects)
float radius; // A path has a radius, i.e how far is it ok for the boid to wander off

//path setup
void setupPath() {
  radius = 20; // Arbitrary radius of 20, this is how much padding the path has for deviation
  points = new ArrayList<PVector>();
}

//Add a point to the path
void addPointToPath(float x, float y) {
  PVector point = new PVector(x, y);
  points.add(point);
}

// Draw the path
void updatePath() {
  //strokeJoin(ROUND);
  
  // Draw thick line for radius
  //stroke(175, 100);
  //strokeWeight(radius*2);
  noFill();
  noStroke();
  beginShape();
  for (PVector v : points) {
    vertex(v.x, v.y);
  }
  endShape(CLOSE);
  // Draw thin line for center of path
  //stroke(255,0,0);
  //strokeWeight(1);
  noFill();
  noStroke();
  beginShape();
  for (PVector v : points) {
    vertex(v.x, v.y);
  }
  endShape(CLOSE);
}
