//Adapted from Learning Processing video chapter
//output a "pixel" based on video input

//video in grid
import processing.video.*;

//size each cell in the grid, ratio of window size to video size
int videoScale = 8; 
int cols, rows;
Capture video;

void captureEvent(Capture video) {
  video.read();
}

void setup() {
  size(640, 480);
  //initialize columns and rows
  cols = width/videoScale;
  rows = height/videoScale;
  video = new Capture(this, cols, rows); //capture small video
  video.start();
}

void draw() {
  video.loadPixels(); //will manipulate video to scale up
  
  //begin loop for columns and rows
  for (int i=0; i<cols; i++) {
    for (int j=0; j<rows; j++) {
      //scale up to draw rectangle at x,y
      int x = i*videoScale;
      int y = j*videoScale;
      color c = video.pixels[i + j*video.width];
      fill(c); //fill square with the colour from this pixel of video
      stroke(0);
      rect(x, y, videoScale, videoScale);
    }
  }
}
