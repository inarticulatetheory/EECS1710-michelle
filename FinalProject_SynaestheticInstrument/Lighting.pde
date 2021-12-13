float theta;
float orbitSpeed;
  
void setupOrbitingLight() {
  float x = -1;
  float y = 0;
  float z = 0;
  theta = 0;
  orbitSpeed = random(0.01, 0.03);
  
  pushMatrix();
    //rotate orbit
    rotate(theta);
    directionalLight(253, 255, 206, x, y, z);
    //increment angle to rotate
    theta += orbitSpeed;
  popMatrix();
}

void updateOrbitingLight() {
  //increment angle to rotate
  theta += orbitSpeed;
}
