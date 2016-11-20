//Tris variables
// oops why did we choose such a complex game I mean wow
long frame_count; // We want some precise timing, so we set a frame counter
int lost_frame_count;
Board board;
LinePiece line1;
ArrayList<LinePiece> lines_list;
int cur_pc_indx; // Which piece in the lines_list are we going to be accessing and moving and stuff?
int game_state;
int print_offset_x = 400;
int print_offset_y = 180;
PImage start_screen;
PImage splash_screen;
PImage block_pic;
PImage state_2_screen;
PImage state_3_screen;
int w_presses; // This is a terrible, terrible hack to make game_state shift from 0 to 1.
                   // When the breakout player hits w, this increments. If the number of presses is greater than 0, then the game state is set to 1
/*
  A quick word on game_state:
    game_state is a fast solution to a complex problem. The idea is it takes one of several values, set during play.
    What is shown on screen is dependent on the value of game_state
    The values it can take, and their meaning, is listed below:
      0: The game has not yet started. No Tetris blocks are shown on screen, the ball has not left the Breakout paddle. Breakout starts the game
      1: Game on! Both players are currently in play
      2: Tetris wins, Breakout loses! This can happen either when the Breakout player fails and the ball falls off their edge of the screen,
            or when Tetris manages to get a single block into row 0
      3: Breakout wins, Tetris loses! This can happen either when the ball reaches the bottom of the screen, or when there's no room for a new block to spawn
    There will be a function called check_game_state that will update the value of the game state at the end of each iteration of the draw loop.
    
*/

Ball ball;
Paddle paddle;

//paddle variables
int paddleWidth;
int paddleHeight;
float paddlePositionX;
float paddlePositionY;
float paddleSpeed;
PImage paddleImage;

//ball variables
int ballRadius;
float ballPositionX;
float ballPositionY;
float ballSpeedX;
float ballSpeedY;
PImage ballImage;
boolean newBall; //is used in ball_class for the sake of convenience 
boolean paddleBallCollision; //variable that identifies if there is a collision between ball and paddle


//key variables
boolean keyRight;
boolean keyLeft;
boolean keyUp;

// game_state checking variables
boolean breakOutLost;
boolean tetrisLost;


void setup() {
  size(1200, 1200);
  frameRate(30);
  start_screen = loadImage("splash3.png");
  splash_screen = loadImage("splash2.png");
  block_pic = loadImage("Block.png");
  paddleImage = loadImage("Paddle.png");
  state_2_screen = loadImage("state_2.png");
  state_3_screen = loadImage("state_3.png");
  game_init();
  
} // end Setup.

void draw(){
  set_winstates(board);
  switch(game_state){
    case 0:
      // Draw the breakout shi...stuff. Don't do anything to Tetris

      image(splash_screen, 0, 0, 1200, 1200);

      //BREAK OUT DRAW CODE
      board.printBoard();
      if (ball.speedX == 0 && ball.speedY == 0){
        image(start_screen, 0, 0, 1200, 1200);
      }
      ball.display();
      
      ball.move();
      ball.checkDrop();

      paddle.display();
      paddle.move();

      //a function that checks for ball/paddle collision
      paddleBallCollision = isCollidingBallPaddle(ball.positionX, ball.positionY, ball.radius, 
        paddle.positionX, paddle.positionY, paddle.paddleWidth, paddle.paddleHeight); 

      //TETRIS DRAW CODE

      board.bounce(ball.positionX,ball.positionY);
      break;
    case 1:
      // DO EVERYTHING
      image(splash_screen, 0, 0, 1200, 1200);
      ////BREAK OUT DRAW CODE
      board.printBoard();
      ball.display();
      
      ball.move();
      ball.checkDrop();

      paddle.display();
      paddle.move();

      ////a function that checks for ball/paddle collision
      paddleBallCollision = isCollidingBallPaddle(ball.positionX, ball.positionY, ball.radius, 
       paddle.positionX, paddle.positionY, paddle.paddleWidth, paddle.paddleHeight); 

      ////TETRIS DRAW CODE
      board.bounce(ball.positionX,ball.positionY);
      lines_list.get(cur_pc_indx).update_lines(board);  
      if(no_currently_moving_piece(lines_list)){
       // Spawn a new piece
       LinePiece newLinePiece  = new LinePiece(int(random(0, 5)), 19, board, int(random(0, 1.5)) );
       lines_list.add(newLinePiece);
      }
      cur_pc_indx = lines_list.size() - 1;
      frame_count += 1;
      if(frame_count % 7 == 0){ // essentially this makes it sliiightly less than two updates per second. Adjust this to make Tetris harder or easier. 
       lines_list.get(cur_pc_indx).set_move_status(board);
       lines_list.get(cur_pc_indx).move_up(board);
      }
      if (frame_count == 120){ frame_count = 0; }// reset it so that the value doesn't get too big.
      break;
    case 2:
      //Show the correct winning picture
      image(state_2_screen, 0, 0, 1200, 1200);
      lost_frame_count += 1;
      if(lost_frame_count == 90){ //i.e 3 seconds have passed
       game_state = 0;
       game_init();
      }
      break;
      
    case 3:
      //Show the correct winning picture
      image(state_3_screen, 0, 0, 1200, 1200);
      lost_frame_count += 1;
      if(lost_frame_count == 90){ //i.e 3 seconds have passed
       game_state = 0;
       game_init();
      }
      break;
  }
}


boolean no_currently_moving_piece(ArrayList<LinePiece> line_array) { // Returns true if none of the current pieces in the array are active
  for (int i = 0; i < line_array.size(); i++) {                         // The point of this function is so that we know if it's time to spawn a new piece or not
    LinePiece tmp = line_array.get(i);
    if (tmp.moving == true) {
      return false;
    }
  }
  return true;
}

boolean isCollidingBallPaddle(
  float circleX, 
  float circleY, 
  int radius, 
  float rectangleX, 
  float rectangleY, 
  int rectangleWidth, 
  int rectangleHeight)
{
  float circleDistanceX = abs(circleX - rectangleX);//-(rectangleHeight/2 + radius);
  float circleDistanceY = abs(circleY - rectangleY);//-(rectangleHeight/2 + radius);
  boolean collided = true;
  float cornerDistance_sq = pow(circleDistanceX - rectangleWidth/2, 2) +
    pow(circleDistanceY - rectangleHeight/2, 2);

  if (circleDistanceX > radius+rectangleWidth/2+20) { 
    collided = false;
  } 
  if (circleDistanceY > radius+rectangleHeight/2) { 
    collided = false;
  }
  if (cornerDistance_sq <= pow(radius, 2)) { 
    collided = true;
  }
  return collided;
}


void keyPressed() {
  //keys for Break Out
  switch(key) {
  case 'w':
  case 'W':
    keyUp = true;
    w_presses += 1;
    break;
  case 'a':
  case 'A':
    paddle.speed = 1;
    keyRight = true;
    break;
  case 'd':
  case 'D':
    paddle.speed = -1;
    keyLeft = true;
    break;
  }
  // add the game_state == 1 checks
  if (keyCode == UP && game_state == 1) { 
    lines_list.get(cur_pc_indx).rotate(board);
    lines_list.get(cur_pc_indx).move_up(board);
    //line1.move_up(board);
    //board.printBoard();
  }
  if (keyCode == LEFT && game_state == 1) {
    lines_list.get(cur_pc_indx).slide_left(board);
    //line1.slide_left(board);
    //background(255);
    //lines_list.get(cur_pc_indx).move_up(board);
    //line1.move_up(board);
    //board.printBoard();
  }
  if (keyCode == RIGHT && game_state == 1) {
    lines_list.get(cur_pc_indx).slide_right(board);
    //line1.slide_right(board);
    //background(255);
    //lines_list.get(cur_pc_indx).move_up(board);
    //line1.move_up(board);
    //board.printBoard();
  }

}

void keyReleased() {
  //keys for Breakout
  // this is here so that the paddle would stop moving when the keys are released
  switch(keyCode) {
  case 'w':
  case 'W':
    newBall = false;
    keyUp = false;
    w_presses += 1;
    break;
  case 'a':
  case 'A':
    //paddle.speed = 0;
    keyRight = false;
    break;
  case 'd':
  case 'D':
    //paddle.speed = 0;
    keyLeft = false;
    break;
  }
  
}

// This function will set win-state (or to be more accurate, game-state) at the start of every draw loop

void set_winstates(Board board){
  if(w_presses != 0){
    game_state = 1;
  } // put this right at the beginning so it can be easily overwritten
  if(breakOutLost){ // see if the ball set breakout loss i.e if it went out of bounds
    game_state = 2;
  }
  
  if(tetrisLost){ // see if the new piece creator set tetris loss i.e nowhere to create new blocks
    game_state = 3;
  }
  
  for(int i = 0; i < 10; i++){
    if(board.blocks_grid[i][0].is_active()){
      game_state = 2;
    }
  }
}


void game_init(){
  lost_frame_count = 0;
  frame_count = 0; // We want some precise timing, so we set a frame counter
  print_offset_x = 400;
  print_offset_y = 180;
  w_presses = 0; // This is a terrible, terrible hack to make game_state shift from 0 to 1.
                     // When the breakout player hits w, this increments. If the number of presses is greater than 0, then the game state is set to 1
  
  paddleWidth = 60;
  paddleHeight = 10;
  paddleSpeed = 0;
  
  //ball variables
  ballRadius = 10;
  ballSpeedX = 0;
  ballSpeedY = 0;
  newBall = false; //is used in ball_class for the sake of convenience 
  
  
  //key variables
  keyRight = false;
  keyLeft = false;
  keyUp = false;
  
  // game_state checking variables
  breakOutLost = false;
  tetrisLost = false;
  
  board = new Board(10, 20);
  line1 = new LinePiece(2, 19, board, 0);
  lines_list = new ArrayList<LinePiece>();
  lines_list.add(line1);

  noStroke();
  paddlePositionX = width/2;
  paddlePositionY = print_offset_y - 20 - paddleHeight*4;
  ballPositionX = paddlePositionX;
  ballPositionY = paddlePositionY + (paddleHeight + ballRadius);
  ballImage = loadImage("Ball.png");
  paddleImage = loadImage("Paddle.png");
  //blockImage = loadImage("Block.png");
  ball = new Ball(ballRadius, ballPositionX, ballPositionY, ballSpeedX, ballSpeedY);
  paddle = new Paddle(paddleWidth, paddleHeight, paddlePositionX, paddlePositionY, paddleSpeed);
}