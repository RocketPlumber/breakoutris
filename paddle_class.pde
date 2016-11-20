// Class Ball

class Paddle {
  int paddleWidth;
  int paddleHeight;
  float positionX; 
  float positionY;
  float speed;

  Paddle (int tempPaddleWidth, int tempPaddleHeight, float tempPositionX, float tempPositionY, float tempSpeed) {
    paddleWidth = tempPaddleWidth;
    paddleHeight = tempPaddleHeight;
    positionX = tempPositionX;
    positionY = tempPositionY;
    speed = tempSpeed;
  }

  void display() {
    rectMode(CENTER);
    //rect(positionX, positionY, paddleWidth*2, paddleHeight*2);
    imageMode(CENTER);
    image(paddleImage, positionX, positionY, paddleWidth*2, paddleHeight*2);
    rectMode(CORNER);
    imageMode(CORNER);
  }

  void move() {
    // move paddle
    if (keyLeft == false && keyRight == false) {
      speed = 0;
    } else if (keyLeft == false && keyRight == true){
      speed = 1.7;
    } else if (keyLeft == true && keyRight == false){
      speed = -1.7;
    }
    positionX = positionX + 5*speed;

    //COLLISIONS
    //check edge function
    if (positionX-(paddleWidth+10) <= print_offset_x && speed == -1.7) {
      positionX = paddleWidth+10 + print_offset_x;
      speed=0;
    } else if (positionX+(paddleWidth+10) >= width-print_offset_x && speed == 1.7) {
      positionX = width - print_offset_x - (paddleWidth+10);
      speed=0;
    }
  }
}