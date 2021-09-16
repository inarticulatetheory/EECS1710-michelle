/*
WORKS CITED
- code using "speed" adapted from https://processing.org/examples/pattern.html
- timer code adapted from http://learningprocessing.com/examples/chp10/example-10-04-timer
*/

//initiate variables for first image
PImage fi;

//initiate variables for background image
PImage bg;
int y;

//initiate variables for timer
int savedTime;
int totalTime = 6000;

//initiate variable for key press to only run once
int programStarted = 0;

//initiate variables for text
PFont font;
int littleFontSize = 18;
int midFontSize = 24;
int bigFontSize = 64;
String introMessage1 = "In the 1970s and early 1980s, every train in the New York City subway system was covered in graffiti. Public opinion ranged from inspiration over this form of public art, to frustration with the lawlessness of the subway system.";
String introMessage2 = "Using photos from the 1970s, participate in the graffiti scene by drawing your own tags.";
String introMessage3 = "But be quick, you only have a few seconds before the transit authorities clean up your work in the 1984 Clean Car Program.";
String introMessage4 = "Press any key to begin.";
String gotcha = "Jump on the next train before New York City Transit authorities catch you!";
String imageCredits = "All images copyright Getty Images";
color bgColor = color(18, 189, 25);


void setup(){
  //general setup
  size(980, 666);
  
  //first image
  fi = loadImage("images/gettyimages-subwaybackground.jpg");
  tint(201,126,14);
  image(fi, 0, 0);
  
  //text setup
  font = createFont("fonts/goudy-heavyface.ttf", littleFontSize);
  textAlign(LEFT);
  textFont(font, littleFontSize);
  int messageX = 33;
  int messageY = 70;
  float textBoxWidth = width/1.5;

  //display intro message
  //last two params create a rectangle for the fill
  
  //shadow offset
  fill(84,55,12);
  textSize(littleFontSize);
  text(introMessage1, messageX + 2, messageY, width/2, height);
  textSize(midFontSize);
  text(introMessage2, messageX + 2, messageY + 200 + 3, textBoxWidth, height);
  text(introMessage3, messageX + 2, messageY + 300 + 3, textBoxWidth, height);
  textSize(bigFontSize);
  text(introMessage4, messageX + 3, messageY + 480 + 3, width, 100);
  
  //main text
  fill(232,199,32);
  textSize(littleFontSize);
  text(introMessage1, messageX, messageY, width/2, height);
  textSize(midFontSize);
  text(introMessage2, messageX, messageY + 200, textBoxWidth, height);
  text(introMessage3, messageX, messageY + 300, textBoxWidth, height);
  textSize(bigFontSize);
  text(introMessage4, messageX, messageY + 480, width, 100);
  
    //timer setup
  savedTime = millis();
}

void draw() {

  if(mousePressed) {

    
    // Params for the mouseTrail() method are
    // current mouse position, previous mouse position
    mouseTrail(mouseX, mouseY, pmouseX, pmouseY);
    
    //set timer before the background resets
    int timePassed = millis() - savedTime;
    
    //if we've reached the timer limit (from totalTime variable)
    if (timePassed > totalTime) {
      backgroundImageLoad(); //load new background image
      savedTime = millis(); //restart timer  
    }   
  }
  }
 
//start program on key press
//but only run once
void keyPressed() {
  if (programStarted == 0) {
    backgroundImageLoad();
    programStarted ++;
  }
}

/* METHOD TO CREATE "GRAFFITI" */
void mouseTrail(int x, int y, int px, int py) {
  float speed = random(abs(x-px)) + random(abs(y-py));
  
  //use random stroke for organic look
  fill(random(255),random(255),random(255));
  
  //create multiple ellipses to simulate spray paint
  //use random numbers for the other x, y values for an organic look
  int sprayBoundary = 10;
  float spraySize = random(6);
  noStroke(); //get rid of stroke on all ellipses
  ellipse(x, y, spraySize, spraySize);
  ellipse(x + random(sprayBoundary), y + random(sprayBoundary), spraySize, spraySize);
  ellipse(x + random(sprayBoundary), y + random(sprayBoundary), spraySize, spraySize);
  ellipse(x + random(sprayBoundary), y + random(sprayBoundary), spraySize, spraySize);
  ellipse(x + random(sprayBoundary), y + random(sprayBoundary), spraySize, spraySize);
}

/* METHOD TO LOAD A RANDOM IMAGE */
void backgroundImageLoad(){
    //load a random background image
    int imageNumber = round(random(11)+1);
    bg = loadImage("images/gettyimages-subwaybackground" + imageNumber + ".jpg"); //must be same size as size()
    background(bg);
}
