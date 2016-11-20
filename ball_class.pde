// Class Ball

class Ball {
  int radius;
  float positionX; 
  float positionY; 
  float speedX; 
  float speedY; 

  Ball (int tempRadius, float tempPositionX, float tempPositionY, float tempSpeedX, float tempSpeedY) {
    radius = tempRadius;
    positionX = tempPositionX;
    positionY = tempPositionY;
    speedX = tempSpeedX;
    speedY = tempSpeedY;
  }

  void display() {
    fill(210,180,0);
    ellipse(positionX, positionY, radius*2, radius*2);

  }

  void move() {

    // simply move
    positionX = positionX + 10*speedX;
    positionY = positionY + 10*speedY;


    //COLLISIONS
    // checkEdges/collision
    if (positionX-radius <= print_offset_x || positionX+radius >= width - print_offset_x) {
      speedX = -speedX;
    }
    if (positionY+radius >= height - print_offset_y) { 
      speedY = -speedY;
    }

    //collision with paddle | bounce ball
    if (paddleBallCollision) {
      positionY = paddle.positionY + (paddle.paddleHeight/2 + radius + 1) ;
      speedY *= -1;
      speedX = paddle.speed*random(0, 1);
      if (paddle.speed == 0) {
        speedX = random(-0.8, 0.8);
      } else {
        speedX = -paddle.speed*random(0.3, 1);
      }
    }
    
    //NEW BALL
    // make ball move with paddle if it is a new ball 
    if (speedY == 0) {
      //speedX = paddle.speed;
      positionX = paddle.positionX;
      if (keyUp == true) {
        if (paddle.speed == 0) {
          speedX = random(-1, 1);
        } else {
          speedX = -paddle.speed*random(0, 1);
        }
        //println(speedX);
        speedY = -1;
      }
    }

    // keep ball on paddle when paddle gets to the edge  
    if (positionX-(paddleWidth+10) <= 0 && keyLeft == true && newBall == true) {
      speedX=0;
    } else if (positionX+(paddleWidth+10) >= width && keyRight == true && newBall == true) {
      speedX=0;
    }
  }

  void checkDrop() {
    if (positionY <= (print_offset_y -10 - 50)) { 
      println("Breklos");
      breakOutLost = true;
      positionY = paddle.positionY+(paddleHeight+radius); //locate ball back on the paddle
      positionX = paddle.positionX;
      speedY = 0;
      speedX = 0; 
      newBall = true;   

      //maybe we should add a min time here before you can launch ball again to increase difficulty
    }
  }
}