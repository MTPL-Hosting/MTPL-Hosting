// tweaked changes
// velX = -7
// check that the ball is not out of the bounds of the screen - new variable "inScreen"
// ai paddle stops moving if out of screen


/* TO-DOs
* if gravity is OFF, then you MUST chance all elastic moduli to 1.0!!!!
* define maxPoints = 10;
* "winner" - whoever has the higher points, first
* resetBall method
	* reset ball position
	* reset ai position
* resetGame method
	* resetBall()
	* reset points
* gameOver check method
	* if either players' points exceeds points limit
* gameOver screen
* gameOver button
*/


int width = 600;
int height = 400;

void setup() {
  frameRate(30);
  size(600, 400);
}

int i = 1;
float f = 2.05;

float posX = 200;
float posY = 200;

int ballSize = 20;

float elasticModulusX = 1.0;
float elasticModulusY = 0.96;

float velX = -7;
float velY = 10;

boolean gravityOn = true;


int playerX = 50;
int playerY = height/2;
int playerPoints = 0;

// right side ai
int aiX = width - 50;
int aiY = height/2;
int aiPoints = 0;

int aiSpeed = 10;

int paddleWidth = 20;
int paddleHeight = 100;


// check if the ball is touching the player paddle
boolean rightEdgePlayer = (posX - ballSize/2) < (playerX + paddleWidth/2);
boolean leftEdgePlayer = (posX + ballSize/2) > (playerX - paddleWidth/2);

boolean topEdgePlayer = (posY + ballSize/2) > (playerY - paddleHeight/2);
boolean bottomEdgePlayer = (posY - ballSize/2) < (playerY + paddleHeight/2);



boolean rightEdgeAI = (posX - ballSize/2) < (aiX + paddleWidth/2);
boolean leftEdgeAI = (posX + ballSize/2) > (aiX - paddleWidth/2);

boolean topEdgeAI = (posY + ballSize/2) > (aiY - paddleHeight/2);
boolean bottomEdgeAI = (posY - ballSize/2) < (aiY + paddleHeight/2);

boolean inScreen = true;

int maxPoints = 1;

boolean gameOver() {
  return (playerPoints > maxPoints || aiPoints > maxPoints);
}

void resetBall() {

}

void draw() {
  background(255, 255, 255);

  playerY = mouseY;
  
  inScreen = (posX - ballSize/2) > 0 && (posX + ballSize/2) < width;

  //////////////////////////////////////////
  // Physics
  
  // gravity
  if (gravityOn) {
    velY += 1;
  }
  
  
  
  
  /////////////////////////////////////////////////
  // nice big space for us
  
  // update the variables checking whether it hits the player or ai paddles
  rightEdgePlayer = (posX - ballSize/2) < (playerX + paddleWidth/2);
  leftEdgePlayer = (posX + ballSize/2) > (playerX - paddleWidth/2);

  topEdgePlayer = (posY + ballSize/2) > (playerY - paddleHeight/2);
  bottomEdgePlayer = (posY - ballSize/2) < (playerY + paddleHeight/2);



  rightEdgeAI = (posX - ballSize/2) < (aiX + paddleWidth/2);
  leftEdgeAI = (posX + ballSize/2) > (aiX - paddleWidth/2);

  topEdgeAI = (posY + ballSize/2) > (aiY - paddleHeight/2);
  bottomEdgeAI = (posY - ballSize/2) < (aiY + paddleHeight/2);
  
  
  //////////////////////////////////////////
  
  // check if its hitting the player's paddle
  if (rightEdgePlayer && leftEdgePlayer && topEdgePlayer && bottomEdgePlayer && velX < 0) {
    velX = -velX * elasticModulusX;
  }
  
  // check if its hitting the ai's paddle
  if (rightEdgeAI && leftEdgeAI && topEdgeAI && bottomEdgeAI && velX > 0) {
    velX = -velX * elasticModulusX;
  }
  
  // bottom wall
  if ((posY + ballSize/2) >= height && (velY > 0)) {
    velY = -velY * elasticModulusY;
  }
  
  // top
  if ((posY - ballSize/2) <= 0 && (velY < 0)) {
    velY = -velY * elasticModulusY;
  }
  
  // left wall - ai scores
  if (posX - ballSize/2 < 0) {
      if (!gameOver()) {
        aiPoints += 1;
        resetBall();
      }
  }
  
  // right wall - player scores
  if (posX + ballSize/2 > width) {
      if (!gameOver()) {
        playerPoints += 1;
        resetBall();
      }
  }
  
  
  posX = posX + velX;
  posY = posY + velY;
  
  
  ///////////////////////////////////
  // Artificial Intelligence
  if ((posY - ballSize/2) > aiY - paddleHeight/2 && inScreen) {
  	aiY += aiSpeed;
  }
  if ((posY + ballSize/2) < aiY + paddleHeight/2 && inScreen) {
  	aiY -= aiSpeed;
  }
  
  
  //////////////////////////////////////////
  // Drawing
  
  // De balle
  //fill(255, 150, 150);
  fill(0, 150, 255);
  noStroke();
  ellipse(posX, posY, ballSize, ballSize);
  
  
  // Player's paddle;
  fill(255, 150, 0);
  rect(playerX - paddleWidth/2, playerY - paddleHeight/2, paddleWidth, paddleHeight);
  
  
  rect(aiX - paddleWidth/2, aiY - paddleHeight/2, paddleWidth, paddleHeight);
  
  // scoreboard
  // magenta
  // (r, g, b)
  fill(255, 0, 255);
  textSize(50);
  text("Player: " + playerPoints, 75, 50);
  text("AI: " + aiPoints, 325, 50);
}
