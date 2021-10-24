/* ===== CODE CITED ===== */
// 1. Concepts of multiple game screens (e.g., start, gameplay, game over) from
// "Flappy Pong" game tutorial - Oguz Gelal, Toptal
// https://www.toptal.com/game/ultimate-guide-to-processing-simple-game
// ---
// 2. Collision detection adapted from 
//   a)  Processing.org bouncy bubbles example
//       Attributed to Keith Peters
//       https://processing.org/examples/bouncybubbles.html
//   b) Processing.org Circle Collision with Swapping Velocities
//       Attributed to Ira Greenberg
//       https://processing.org/examples/circlecollision.html
// ---
// 3. Code from artillery game, week 7 in class, adapted to "fire" tears
// Adapted from
// https://www.emanueleferonato.com/2007/04/28/create-a-flash-artillery-game-step-1/
// ---
// 4. Word Arrays from
// https://gist.github.com/ijmacdowell/8325491
// ---
// 5. Characters on a curve adapted from
// http://learningprocessing.com/examples/chapter-17/example-17-8/
/* ===== END CODE CITED ===== */


/* ===== VARIABLES START =====*/
PFont fA;
PFont fV;

//Variable to indicate active game screen
int gameScreen = 0; //0 = initial screen, 1 = gameplay, 2 = game over

//Static game screens
String rules;
String ready;
String title;

//movement variables
float gravity = 0.03;
float friction = -0.9;
float airFriction = 0.0001; //constant friction from air

//edge variables
float bottom;

//puddle variables
float tide;
float incrementor = 1;

//bubble variables
int bubbleCount;

//poetry variables
String[] wordType = {"noun", "adjective", "verb"}; //used to populate each word;
String finalPoem;
String poetryConstellation = ""; //stores poem in progress

//set up classes for visual elements
Eye eye;
Puddle puddle;
ArrayList<Bubbles> bubbles;
Poem poem;


//set up an array of adj
//set up an array of nouns
//set up an array of adverbs
//set up an array of verbs

//if time, maybe there's a computer-controlled "ball" (or smile)
//that will float around and pick happy words
/* ===== VARIABLES END =====*/


/* ===== SETUP START ===== */
void setup() {
  size(1000, 700);
  fA = loadFont("ASTORIA.vlw");
  fV = loadFont("VCR.vlw");
  textFont(fV);
  
  //static text
  title = "SAD POETRY GENERATOR"; 
  rules = "LIKE ALL TEENAGERS WHO CAME BEFORE YOU, YOU ARE SUFFERING FROM THE TRAGIC AND PROFOUND EXPERIENCE OF BEING. \n AND, LIKE ALL TEENAGERS WHO CAME BEFORE YOU, NO ONE UNDERSTANDS YOUR UNIQUE AND SPECIFIC EXPRESSION OF SELF. \n PUT THOSE TEARS TO PRODUCTIVE USE: BUILD YOUR SADDEST POEM BY POPPING WORDS. \n THEY'LL FINALLY UNDERSTAND YOU WHEN THEY READ YOUR FINAL CREATION";
  ready = "PRESS SPACE TO DROP A TEAR / CLICK ANYWHERE TO START";
  
  //dimensions
  bottom = height - tide; //adjust bottom edge as tide rises
  
  //set up eye
  eye = new Eye(mouseX);
  
  //set up tide
  puddle = new Puddle(); //used for when tears hit bottom
  tide = 0.1; //can't be 0 due to `tide/2` in Class
  incrementor = 1;
  
  //set up bubbles
  bubbleCount = 34;
  bubbles = new ArrayList<Bubbles>(); //place bubble randomly in canvas
  for (int i=0; i<bubbleCount; i++) {
    bubbles.add(new Bubbles(random(0, width), random(0,height), random(40,90)));
  }
  
  //set up poetry
  poem = new Poem();
}


/* ===== SETUP END ===== */


/* ===== DRAW START ===== */
void draw() {
  //retrieve correct game content by the value of the screen
  if (gameScreen == 0) {
    //initial screen
    initialScreen();
  } else if (gameScreen == 1) {
    //gameplay
    gamePlay();
  } else if (gameScreen == 2) {
    //game over
    roundOver();
  }
}
/* ===== DRAW END ===== */


/* ===== START INITIALSCREEN START ===== */
void initialScreen() {
  //visuals
  background(8,50,255);
  
  textAlign(CENTER);
  fill(255);
  textSize(50);
  text(title, width/2, height/3);
  
  textLeading(40);
  textSize(15);
  text(rules, width/2, height/2);
  
  textSize(15);
  text(ready, width/2, height - height/4);


  
  //start game when click happens
  if (mousePressed) {
    if(gameScreen == 0) {
      gameScreen = 1;
    }
  }
}
/* ===== END INITIALSCREEN END ===== */


/* ===== GAMEPLAY START ===== */
void gamePlay() {
  background(40, 20, 100);
  poem.count();
  eye.run();
  puddle.draw();
  
  //clean up any "popped" bubbles in the array
  for (int i=bubbles.size()-1; i>0; i--) {
    Bubbles b = bubbles.get(i);
    bubbles.get(i-1).checkCollision(b);
      if (b.active) {
        b.run();
      } else {
        bubbles.remove(i);
      }
    }
  }
/* ===== GAMEPLAY END ===== */


/* ===== ROUNDOVER START ===== */
void roundOver() {
  //visuals
  background(91,35,165);
  textAlign(CENTER);
  textSize(25);
  fill(240,180,240);
  text(finalPoem, width/2, height/2);
  
  /*
  //start game when click happens
  if (mousePressed) {
      gameScreen = 1;
    }
    */
}
/* ===== ROUNDOVER END ===== */


/* ===== HIT DETECTION START ===== */
boolean tempHitDetection(PVector p1, PVector p2, PVector hitbox) {
  hitbox = hitbox.copy().div(2);
  if (p1.x >= p2.x - hitbox.x && p1.x <= p2.x + hitbox.x && p1.y >= p2.y - hitbox.y && p1.y <= p2.y + hitbox.y) {
    return true;
  } else {
    return false;
  }
}
/* ===== HIT DETECTION END ===== */
