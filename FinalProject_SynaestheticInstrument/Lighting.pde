void setupOrbitingLight() {
  float x = -1;
  float y = 0;
  float z = 0;
  float theta;

}

void updateOrbitingLight() {
  directionalLight(253, 255, 206, x, y, z);
  x += 3;
}
