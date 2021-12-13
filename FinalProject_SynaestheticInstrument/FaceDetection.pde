/* CODE CITED:
- This code is adapted from a starting point of the OpenCV face detection example
*/

import gab.opencv.*;
import java.awt.Rectangle;
import processing.video.*;

Capture video;
OpenCV getface;

Rectangle[] faceDetections;
Faces face;

void captureEvent(Capture video) {
  video.read();
}

void setupFaceDetection() {
  video = new Capture(this, width/2, height/2); //reduce capture size for speed
  video.start();
  
  getface = new OpenCV(this, width/2, height/2); //reduce capture size for speed
  getface.loadCascade(OpenCV.CASCADE_FRONTALFACE); 
}

void updateFaceDetection() {
  scale(2); //scale video capture back up
  
  //BUG: OpenCV will not work in 3D without image displaying
  tint(0, 200); //make image transparent--comment to debug with video image
  image(video, 0, 0); //display video to screen
  
  
  //load video
  getface.loadImage(video);

  //find facial features
  faceDetections = getface.detect();
  
  /* 
  * FACES
  */
  if (faceDetections.length > 0) {
    //create a face for just the first detection so there's always only one face
    //could be interesting to have multiple though, in case friends play together
    face = new Faces(faceDetections[0].x, faceDetections[0].y, faceDetections[0].width, faceDetections[0].height);
    face.display();
    face.update();

    /*
    //placeholder to QA the detection if needed
    stroke(255, 255, 0);
    strokeWeight(2);
    translate(0, 0, 0);
    rect(faceDetections[0].x, faceDetections[0].y, faceDetections[0].width, faceDetections[0].height);
    */
  }
}
