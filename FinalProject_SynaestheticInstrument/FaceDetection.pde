/* CODE CITED:
- This code is adapted from a starting point of the OpenCV face detection example
*/

import gab.opencv.*;
import java.awt.Rectangle;
import processing.video.*;

Capture video;
OpenCV getface, geteyes;

Rectangle[] faceDetections, eyeDetections;
Faces[] face;
Eyes[] eye;


void captureEvent(Capture video) {
  video.read();
}

void setupFaceDetection() {
  video = new Capture(this, width/2, height/2); //reduce capture size for speed
  video.start();
  
  getface = new OpenCV(this, width/2, height/2); //reduce capture size for speed
  getface.loadCascade(OpenCV.CASCADE_FRONTALFACE);  
  
  geteyes = new OpenCV(this, width/2, height/2); //reduce capture size for speed
  geteyes.loadCascade(OpenCV.CASCADE_EYE);  
}

void updateFaceDetection() {
  scale(2); //scale video capture back up
  //image(video, 0, 0); //display video to screen
  
  //face
  getface.loadImage(video);
  faceDetections = getface.detect();
  
  //eyes
  geteyes.loadImage(video);
  eyeDetections = geteyes.detect();
  
  /* 
  * FACES
  *
  * THIS IS ACTING ON THE FIRST (0th) OBJECT DETECTION ONLY
  * if you had more than one
  * change faces[0] to faces[i]
  */
  for (int i = 0; i < faceDetections.length; i++) {
    
    //create a face for this detection
    face = new Faces[faceDetections.length];
    face[i] = new Faces(faceDetections[i].x, faceDetections[i].y, faceDetections[i].width, faceDetections[i].height);
    face[i].display();
    face[i].update();

    /*
    //placeholder to QA the detection if needed
    stroke(255, 255, 0);
    strokeWeight(2);
    rect(detections[0].x, detections[0].y, detections[0].width, detections[0].height);
    */
  }
  
  /* EYES */
    for (int i = 0; i < eyeDetections.length; i++) {
      //create a eye for this detection
      eye = new Eyes[eyeDetections.length];
      eye[i] = new Eyes(eyeDetections[i].x, eyeDetections[i].y, eyeDetections[i].width, eyeDetections[i].height);
      eye[i].display();
      //eye[i].update();

      /*
      //placeholder to QA the detection if needed
      stroke(255, 255, 0);
      strokeWeight(2);
      rect(eyeDetections[0].x, eyeDetections[0].y, eyeDetections[0].width, eyeDetections[0].height);
      */
  }
}
