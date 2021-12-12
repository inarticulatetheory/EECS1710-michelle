/* CODE CITED:
- This code is adapted from a starting point of the OpenCV face detection example
*/

import gab.opencv.*;
import java.awt.Rectangle;
import processing.video.*;

Capture video;
OpenCV opencv;

Rectangle[] detections;
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
  //image(video, 0, 0); //display video to screen
  detections = opencv.detect();
  
  /* 
  * THIS IS ACTING ON THE FIRST (0th) OBJECT DETECTION ONLY
  * if you had more than one
  * change faces[0] to faces[i]
  */
  for (int i = 0; i < detections.length; i++) {
    
    //create a face for this detection
    face = new Faces[detections.length];
    face[i] = new Faces(detections[i].x, detections[i].y, detections[i].width, detections[i].height);
    face[i].display();
    face[i].update();

    /*
    //placeholder to QA the detection if needed
    stroke(255, 255, 0);
    strokeWeight(2);
    rect(detections[0].x, detections[0].y, detections[0].width, detections[0].height);
    */
  }
}
