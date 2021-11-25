/* CODE CITED:
- Working with pixels tutorial from https://processing.org/tutorials/pixels

*/

PImage imageIn, imageOut;
float rows;
float j; //random

void setup() {
  size(600, 600);
  imageIn = loadImage("monalisa.jpg");  
  
  //create blank image same size as imageIn
  imageOut = createImage(imageIn.width, imageIn.height, RGB);
  
  //imageOut = imageIn.get();
  //imageOut.loadPixels(); //load the pixels, I would like to speak with them!
  
  j = random(1,10); //has to be greater than zero
}

void draw() {
  float threshold = 190;
  
  //load both image's pixels
  imageIn.loadPixels();
  imageOut.loadPixels();
  
  /* map takes one set of values and sets an equivalent in another set */
  //rows = map(mouseX, 0, width, 0, 255); //map colour scale (0-255) to 0-width
  
  /*
  for (int i=0; i<imageOut.pixels.length; i++) {
    if (i % j == 0) { //do something to every 5th pixel
      color c = color(random(255));
      imageOut.pixels[i] = c;
    }
  }
  */
  
  //loop through every pixel column
  for (int x=0; x<imageIn.width; x++) {
    //then loop through every pixel row
    for (int y=0; y<imageIn.height; y++) {
      //get actual pixel location
      int loc = x + y * imageIn.width;
      
      //test brightness against threshold
      if (brightness(imageIn.pixels[loc]) > threshold) {
        imageOut.pixels[loc] = color(255);
      } else {
        imageOut.pixels[loc] = color(0);
      }
    }
  }
  
  
  imageOut.updatePixels(); //Go ahead and update the pixels, I'm all done!
  
  image(imageOut, 0, 0, width, height);

}
