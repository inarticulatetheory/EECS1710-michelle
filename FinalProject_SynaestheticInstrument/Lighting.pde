 void setupLight() {
  float x = -1;
  float y = 0;
  float z = 0;
  directionalLight(253, 255, 206, -5, height/2, -100);
 // Orange point light on the right
  pointLight(150, 100, 0, // Color
             200, -150, -100); // Position
           }
