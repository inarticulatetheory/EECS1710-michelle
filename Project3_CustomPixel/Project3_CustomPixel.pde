//CROSS STITCH

/* CODE CITED:
- Working with pixels tutorial from https://processing.org/tutorials/pixels

*/

PImage imageIn;
int grid = 5;
int hoop; //size of embroidery hoop

void setup() {
  size(600, 600);
  imageIn = loadImage("monalisa.jpg");  
  imageIn.resize(width, height); //stretch image to canvas
  
  hoop = width-20;

  /* START setup the "fabric" grid */
  stroke(180);
  for (int i=0; i<width; i+=grid) {
    for (int j=0; j<height; j+=grid) {
      line(i,0,i,height);
      line(0,j,width,j);
    }
  }
  /* END setup the fabric grid */
  
  /* START EMBROIDERY HOOP*/
  //main hoop
  stroke(211, 184, 130);
  strokeWeight(15);
  noFill();
  ellipse(width/2, height/2, hoop, hoop);
  
  //hoop accent
  stroke(234, 207, 152);
  strokeWeight(2);
  noFill();
  ellipse(width/2, height/2, hoop+5, hoop+5);
  ellipse(width/2, height/2, hoop-5, hoop-5);
  
  //hoop shadow
  stroke(118, 101, 67);
  strokeWeight(2);
  noFill();
  ellipse(width/2, height/2, hoop-12, hoop-12);
  /*END EMBROIDERY HOOP*/
}

void draw() {  


  
  /* pointilism effect */

  //pick random point
  int x = int(random(imageIn.width));
  int y = int(random(imageIn.height));
  
  //check if point is within embroidery hoop w/ Pythagoras
  int dx = abs(x-width/2);
  int dy = abs(y-height/2);
  
  //(x-center_x)^2 + (y - center_y)^2 < radius^2
  if (dx*dx + dy*dy > (hoop/2 - 20)*(hoop/2 - 20)) {
    print("out");
  } else {
    print("in");
    int loc = x + y * imageIn.width;
    
    //load up RGB color in source image
    imageIn.loadPixels();
    float r = red(imageIn.pixels[loc]);
    float g = green(imageIn.pixels[loc]);
    float b = blue(imageIn.pixels[loc]);
  
    stroke(r, g, b, 200);
    strokeWeight(3);
    //fill(r, g, b, 100);
    //instead of setting a pixel, draw an X with the colour
    line(x,y,x+grid,y-grid);
    line(x, y-grid, x+grid, y);
  }
}
