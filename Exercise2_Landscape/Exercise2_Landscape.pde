int sky = 100; //height of sky

Sun sun = new Sun();
//HighwayLines lines = new HighwayLines();
Mountains mountain = new Mountains();

void setup() {
  size(1200,600,P2D);
  frameRate(60);
  //lines = new HighwayLines();
}

void draw() {
  frameRate(60);
  
  noStroke();
  
  //sky
  fill(224, 168, 77);
  rectMode(CENTER);
  rect(width/2, sky/2, width, sky);
  

  sun.display();
  sun.rise();
  
  //road
  fill(160, 152, 124);
  rect(width/2, (height + sky) /2, width, height - sky);

  
  fill(67,75,82);
  quad(width/2 - 20, sky, width/2 + 20, sky, width/2 + 200, height, width/2 - 200, height);

   //lines.paint();
   //lines.drive();
  
  mountain.display();
  mountain.move();
}
