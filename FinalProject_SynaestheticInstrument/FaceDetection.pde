/* CODE CITED:
- This code is adapted from a starting point of the OpenCV face detection example
*/

import gab.opencv.*;
import java.awt.Rectangle;
import processing.video.*;

Capture video;
OpenCV opencv;

Rectangle[] faces;
Faces[] face;


void captureEvent(Capture video) {
  video.read();
}

void setupFaceDetection() {
  video = new Capture(this, width/2, height/2); //reduce capture size for speed
  video.start();
  
  opencv = new OpenCV(this, width/2, height/2); //reduce capture size for speed
  opencv.loadCascade(OpenCV.CASCADE_FRONTALFACE);  
}

void updateFaceDetection() {
  scale(2); //scale video capture back up
  opencv.loadImage(video);
  image(video, 0, 0); //display video to screen
  //image(opencv.getInput(), 0, 0);

  noFill();
  //stroke(0, 255, 0);
  //strokeWeight(2);
  faces = opencv.detect();
  
  /* 
  * THIS IS ACTING ON THE FIRST (0th) OBJECT DETECTION ONLY
  * if you had more than one
  * change faces[0] to faces[i]
  */
  for (int i = 0; i < faces.length; i++) {
    stroke(255, 255, 0);
    strokeWeight(2);
    ellipseMode(CORNER);
    ellipse(faces[0].x, faces[0].y, faces[0].width, faces[0].height);
    point(faces[0].x, faces[0].y);
  }
}
