class Board{

  // The Board needs to have a size in two dimensions, as well as a 2D array of blocks
  int x_size, y_size;
  Block[][] blocks_grid;
  int current_full_lines = 2; // When the game starts, there's two fully filled lines on the screen. As the game goes on, this value should change.
  color p_col = color(255, 0, 0); // defaulting to red right now, the current color solution is a temporary workaround.
  int lowest_filled_row = 10; //What's the lowest row we know to be full?
  Board(int x_blocks, int y_blocks){

    x_size = x_blocks;
    y_size = y_blocks;

    blocks_grid = new Block[x_size][y_size]; // Initialize the grid of Blocks that form the main structure of the board.

    for(int i = 0; i < x_size;i++){ // initialize each block in the gid
      for(int j = 0; j < y_size; j++){
        blocks_grid[i][j] = new Block(i, j);
      }
    }

    for(int i = 0; i < x_size; i++){ // Make two rows of blocks already present
      blocks_grid[i][9].activate();
      blocks_grid[i][10].activate();
    }

  }

  void printBoard(){
    // Iterate over the block grid and print each block
    for(int x = 0; x < x_size; x++){
      for(int y = 0; y<y_size; y++){
        blocks_grid[x][y].display(p_col);
      }
    }
  }

  boolean tetris_has_won(){
    for(int i = 0; i < y_size; i++){
      if(blocks_grid[0][i].is_active()){
        return true;
      }
    }
    return false;
  }

  boolean line_is_full(int row_y){
    for(int i = 0; i < x_size; i++){
      if(blocks_grid[i][row_y].is_not_active()){
        return false;
      }
    }
    return true;
  }

  //void update_lines(){ // Count how many rows on the board are filled. If it's more than the last cycle, move all rows up
  //  for(int a = lowest_filled_row + 1; a < y_size; a++){
  //    if(line_is_full(a)){
  //      lowest_filled_row = a-1;
  //      for(int i = 0; i < y_size - 1; i++){
  //        for(int j = 0; j < x_size; j++){
  //          if(blocks_grid[j][i+1].is_active()){
  //            blocks_grid[j][i].activate();
  //          }
  //          else if(blocks_grid[j][i+1].is_not_active()){
  //            blocks_grid[j][i].deactivate();
  //          }
  //          // change the state of the current block to match the block below it
            
  //        }
  //      } 
  //    }
  //  }
  //}

  void bounce(float ballX, float ballY){
     int x_val = int(ballX);
     int y_val = int(ballY);
     
     x_val -= print_offset_x;
     x_val /= b_size;
     // Now x_val is the index of the block to check
     
     y_val -= print_offset_y;
     y_val /= b_size;
     //y_val -= b_size; 
     
       if(y_val>0 && blocks_grid[x_val][y_val].is_active()){
         ball.speedX *= -1;
         ball.speedY *= -1;
         blocks_grid[x_val][y_val].deactivate();
       }
  }
  
  
  //void shift_line_up(){
  //  // This function should push all the blocks that are currently active up by one
  //}

  //boolean breakout_loss(){
  //  // This function will check if blocks have been pushed to row x = 0, i.e breakout player lost
  //}

}