// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

// Path Following

class Path {

  // A Path is an arraylist of points (PVector objects)
  ArrayList<PVector> points;
  // A path has a radius, i.e how far is it ok for the boid to wander off
  float radius;

  Path() {
    // Arbitrary radius of 20
    radius = 20;
    points = new ArrayList<PVector>();
  }

  // Add a point to the path
  void addPoint(float x, float y) {
    //PVector point = new PVector(x, y);
    PVector point = new PVector(x, y- height/3);
    points.add(point);
  }
}
