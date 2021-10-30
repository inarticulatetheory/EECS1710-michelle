// The Flock (a list of Life objects)

class Flock {
  ArrayList<Life> life; // An ArrayList for all the boids

  Flock() {
    life = new ArrayList<Life>(); // Initialize the ArrayList
  }

  void run() {
    for (Life l : life) {
      l.run(life);  // Passing the entire list of boids to each boid individually
    }
  }

  void addLife(Life l) {
    life.add(l);
  }

}
