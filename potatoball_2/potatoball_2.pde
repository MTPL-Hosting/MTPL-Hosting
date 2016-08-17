// tweaked changes
// velX = 7
// ballSize = 20
// check that the ball is not out of the bounds of the screen


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

float velX = 7;
float velY = 10;

boolean gravityOn = true;


int playerX = 50;
int playerY = height/2;

// right side ai
int aiX = width - 50;
int aiY = height/2;

int aiSpeed = 10;

int paddleWidth = 20;
int paddleHeight = 100;

void draw() {
  background(255, 255, 255);

  playerY = mouseY;

  //////////////////////////////////////////
  // Physics
  
  // gravity
  if (gravityOn) {
    velY += 1;
  }
  
  
  // right paddle
  if ((posX + ballSize/2) >= aiX - paddleWidth/2
  && (posX - ballSize/2) <= aiX + paddleWidth/2
  && (posY - ballSize/2) < aiY + paddleHeight/2
  && (posY + ballSize/2) > aiY - paddleHeight/2
  && (velX > 0)) {
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
  
  // left
  if ((posX - ballSize/2) <= playerX + paddleWidth/2
  && (posX + ballSize/2) >= playerX - paddleWidth/2
  && (posY - ballSize/2) < playerY + paddleHeight/2
  && (posY + ballSize/2) > playerY - paddleHeight/2
  && (velX < 0)) {
    velX = -velX * elasticModulusX;
  }
  
  posX = posX + velX;
  posY = posY + velY;
  
  
  ///////////////////////////////////
  // Artificial Intelligence
  if ((posY - ballSize/2) > aiY - paddleHeight/2) {
  	aiY += aiSpeed;
  }
  if ((posY + ballSize/2) < aiY + paddleHeight/2) {
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
}