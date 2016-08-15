/*
* Things to change
* screen dimensions
* mod. of elasticity for X and T directions
* starting location of ball in terms of screen size
* comment out code cause ball to bounce off sides of wall
  * instead scores points
  * choose who the "winner" is (whoever has more points)
* points system
* let ball go further out of the sides

* next step... disable gravity, 4 player Space Pong?

*/


int width = 600;
int height = 400;

void setup() {
  frameRate(30);
  size(600, 400);
}

float ballSize = 20;

int i = 1;
float f = 2.05;

float posX = width/2;
float posY = height/2;

float velX = 9;
float velY = 10;

float elasticModulusX = 1.0;

// prevent the ball from going insane
float elasticModulusY = 0.96;

boolean gravityOn = true;


int playerY;
int playerX = 50;
int playerPoints = 0;

int aiX = width - 50;
int aiY;
int aiSpeed = 7;
int aiPoints = 0;

int paddleSize = 100;
int paddleThickness = 20;

String winner = "";

String pointTo = "";

int maxPoints = 10;

boolean gameOver() {
  // returns the "truth" of the statement below
  return playerPoints >= maxPoints || aiPoints >= maxPoints;
}

void resetBall() {
  // -8 or 8
  velX = (round(random(0, 1)) * 2 - 1) * 9;
  velY = round(random(8, 10));

  posX = width/2;
  posY = height/2;

  aiY = height/2;
}

void resetGame() {
  playerPoints = 0;
  aiPoints = 0;

  resetBall();
}

void draw() {
  background(255, 255, 255);

  //////////////////////
  // update player here
  if (!gameOver()) {
    playerY = mouseY;
  }

  //////////////////////////
  // Physics
  
  // gravity
  if (gravityOn) {
    velY += 1;
  }
  
  
  // right wall
  if ((posX + ballSize/2) >= (width + 50) && (velX > 0)) {
    // velX = -velX * elasticModulusX;

    // a point for the player!
    if (!gameOver()) {
      playerPoints += 1;
    }

    if (!gameOver()) {
      resetBall();
    }
  }
  
  // bottom wall
  if ((posY + ballSize/2) >= height && (velY > 0)) {
    velY = -velY * elasticModulusY;
  }
  
  // top
  if ((posY - ballSize/2) <= 0 && (velY < 0)) {
    velY = -velY * elasticModulusY;
  }
  
  // left
  if ((posX - ballSize/2) <= (0 - 50) && (velX < 0)) {
    // velX = -velX * elasticModulusX;

    // a point for the ai opponent!
    if (!gameOver()) {
      aiPoints += 1;
    }

    if (!gameOver()) {
      resetBall();
    }
  }



  ////////////////////
  // collision with player's paddle

  if (posX - ballSize/2 < playerX + paddleThickness/2 &&
    posX + ballSize/2 > playerX - paddleThickness/2 &&
    posY - ballSize/2 > playerY - paddleSize/2 &&
    posY + ballSize/2 < playerY + paddleSize/2 &&
    velX < 0
    ) {
    // flip ball X direction
    velX = -velX * elasticModulusX;
    
  }

  // collisiont with ai's paddle
    if (posX + ballSize/2 > aiX - paddleThickness/2 &&
    posX - ballSize/2 < aiX + paddleThickness/2 &&
    posY - ballSize/2 > aiY - paddleSize/2 &&
    posY + ballSize/2 < aiY + paddleSize/2
    && velX > 0
    ) {
    // flip ball X direction
    velX = -velX * elasticModulusX;
  }

  
  posX = posX + velX;
  posY = posY + velY;
  
  ////////////////////
  // update opponent here
  if (!gameOver() && posY > aiY + paddleSize/2) {
    aiY += aiSpeed;
  }

  if (!gameOver() && posY < aiY - paddleSize/2) {
    aiY -= aiSpeed;
  }
  
  /////////////////////////
  // Update game logic here
  if (playerPoints > aiPoints) {
    winner = "Player";
  }

  if (aiPoints > playerPoints) {
    winner = "AI Opponent";
  }

  //////////////////////////////////////////
  // Drawing
  noStroke();
  fill(0, 150, 255);
  ellipse(posX, posY, ballSize, ballSize);
  
  // Player
  fill(255, 150, 0);
  rect(playerX - paddleThickness, playerY - paddleSize/2, paddleThickness, paddleSize);

  // AI
  fill(255, 150, 0);
  rect(aiX - paddleThickness, aiY - paddleSize/2, paddleThickness, paddleSize);

  textAlign(LEFT);
  fill(0);
  textSize(20);
  text("Player: " + playerPoints, 50, 50);
  text("AI Opponent: " + aiPoints, width - 200, 50);

  if (gameOver()) {
    fill(255, 255, 255, 150);
    rect(0, 0, width, height);

    fill(0);
    textSize(30);
    textAlign(CENTER);
    text(winner + " wins!", width/2, height/2);
    textSize(15);
    text("Click to restart.", width/2, height/2 + 40);

    if (mousePressed) {
      resetGame();
    }

  }

}