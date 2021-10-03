## Project 1: Creature

For this project, I was inspired by a few technical goals:
* I knew I wanted to learn how to create many objects of the same class, but with different attributes.
* I have been reading and working through _Learning Processing_ by Daniel Schiff and one of the early exercises where a bouncing ball is constrained inside a box made me want to think of where I could take this concept creatively
* I had used image assets in my previous projects, so this time I wanted to limit myself to only using the 2D primitives and really understand how multiple shapes can build up an object rather than relying on an existing image file

Combining these three goals, I came up with a concept around fireflies trapped in a jar. I wanted to have a whimsical take on the project and chose to create a "flock" of fireflies with variable sizes and movement. I did not put airholes in my jar so over time the fireflies begin to die, losing their glow and falling to the bottom of the jar.

I ran into issues with the "dying" process. I knew I wanted my fireflies to lose their glow and turn black once they died, and after time I was able to figure this out through modifying where my colour variables were located. By changing the colour variables in my `die()` function, I could successfully change the firefly body colour. I could not, however, figure out how to stop them from moving once they were dead. I could get them to stick to a certain range of `y` values through constraining, but something about the random values seems to have kept moving their "final resting place." 

Once I learn more about classes I think I will be able to revise this project. When I use the `random()` function in a class, I am still uncertain which sections of code run only once, and which run eery time `draw()` executes. I figured out some functionality through trial and error (e.g., changing the colour of my fireflies) but could not make their wings stop flapping or have them remain dead at the bottom of the jar.

<br />
<strong>All fireflies are alive</strong>
<img src="./Project_1C/screenshots/fireflies_alive.png" width="400px">
<br />
<strong>Over time, some flies die and fall to the bottom of the jar</strong>
<img src="./Project_1C/screenshots/fireflies_dying.png" width="400px">
