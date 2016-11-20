class LinePiece{

  // A Line is a Tetris piece made of four blocks in, well, a line.
  // We are, however, going to rewrite this class to refer to ANY piece of four 
  // Everything we know about the position of the line will be in relation to one 'anchor piece'.

  // The co-ordinates of all four pieces must be known
  int x1, y1, x2, y2, x3, y3, x4, y4;

  // The status of the block, i.e should it move or should it stay still, must be known.
  boolean moving = true;

  int orientation = 0; // For a line, there's two orientations - 0 means flat and 1 means tall.
  
  int pieceClass = 0; // 0 is a line, 1 is a cube, 2 is an L, 3 is a backwards L, 
  
  // We initialize a line by knowing its starting x and y. These are usually going to be y = 19 and x = something between 0 and 6.
  // We need to draw it in its original orientation (flat) by setting all occupied squares to be Active.

  LinePiece(int anchor_x, int anchor_y, Board board, int pieceClass){
    switch(pieceClass){
      case 0:
        // x1,y1 is the anchor piece
        x1 = anchor_x;
        y1 = anchor_y;
    
        // The piece comes in all flat-like, so set all the y-values to be the same.
        y2 = y1;
        y3 = y1;
        y4 = y1;
    
        // Now set the x-values. Each one is one to the right of the next one
        x2 = (x1 + 1);
        x3 = (x2 + 1);
        x4 = (x3 + 1);
        break;
      case 1:
       x1 = anchor_x;
       y1 = anchor_y;
       x2 = x1 + 1;
       y2 = y1;
       x3 = x1;
       y3 = y1 - 1;
       x4 = x2;
       y4 = y3;
       break;
    }
    // Check if any of the four things are already active, in which case, you've lost, there's nowhere to place your piece and tetris has lost, so game_state should go to 3
    if(board.blocks_grid[x1][y1].is_active() || board.blocks_grid[x2][y2].is_active() || board.blocks_grid[x3][y3].is_active() || board.blocks_grid[x4][y4].is_active()){
      tetrisLost = true;
    }
    else{
      // Now activate all the relevant pieces;
      board.blocks_grid[x1][y1].activate();
      board.blocks_grid[x2][y2].activate();
      board.blocks_grid[x3][y3].activate();
      board.blocks_grid[x4][y4].activate(); // Out of Bounds Exception occurs here sometimes - something to do with the left edge of the screen
    }
  }                                       // BUT IT'S SOLVED NOW SO NVM

  void set_move_status(Board board){                           // The line piece has to see if it can move up, or if it should just stay in place

    if(orientation == 0){ // the piece is flat, so we gotta make sure that none of the spots 1 up are currently used
      if(board.blocks_grid[x1][y1-1].is_active() || board.blocks_grid[x2][y2-1].is_active() || board.blocks_grid[x3][y3-1].is_active() || board.blocks_grid[x4][y4-1].is_active()){
        moving = false;
      }
    }
    else{ // The piece is tall, so we need to actually figure things out about orientation
      int current_lowest_y = y1;
      int current_lowest_x = x1;                          // Find out the current lowest y, so that we know where to check for collision
      if(y2 <= current_lowest_y) {current_lowest_y = y2; current_lowest_x = x2;} 
      if(y3 <= current_lowest_y) {current_lowest_y = y3; current_lowest_x = x3;} 
      if(y4 <= current_lowest_y) {current_lowest_y = y4; current_lowest_x = x4;}    // I know this is ugly code, but, well...forgive me, Processing Gods

      // Now that we've got the lowest block (highest up on the screen), we just gots to check if the block one above it is active
      if(board.blocks_grid[current_lowest_x][current_lowest_y - 1].is_active()){
        moving = false;
      }
    }
  }


  void move_up(Board board){
    if(moving){
      // Deactivate all the currently active blocks. 
      board.blocks_grid[x1][y1].deactivate();
      board.blocks_grid[x2][y2].deactivate();
      board.blocks_grid[x3][y3].deactivate();
      board.blocks_grid[x4][y4].deactivate();

      // Decrement the y-values. (pieces move UP the board, that's why)
      y1 -= 1;
      y2 -= 1;
      y3 -= 1;
      y4 -= 1;

      if(y1 == 0 || y2 == 0 || y3 == 0 || y4 == 0){ // you've reached the top! Gratz.
        //board.blocks_grid[x1][y1].activate();
        //board.blocks_grid[x2][y2].activate();
        //board.blocks_grid[x3][y3].activate();
        //board.blocks_grid[x4][y4].activate();
        breakOutLost = true;
      }
      else{
        // Activate all the current blocks.
        board.blocks_grid[x1][y1].activate();
        board.blocks_grid[x2][y2].activate();
        board.blocks_grid[x3][y3].activate();
        board.blocks_grid[x4][y4].activate();
      }
    }
  }

  void rotate(Board board){
    switch(pieceClass){
      case 0:
        if(moving){
          int new_x1, new_y1, new_x2, new_y2, new_x3, new_y3, new_x4, new_y4;
          if(orientation == 0){ // if it's currently flat
            if(y1 != 0 && y1 < 18){ //Make sure that it actually has space to rotate
              if(board.blocks_grid[x1+1][y1-1].is_not_active() && board.blocks_grid[x3-1][y3+1].is_not_active() && board.blocks_grid[x4-2][y4+2].is_not_active()){ // Make sure that it won't overlap into other pieces
                // Rotation: modify the locations of points 1, 3 and 4. 2 is stable, we rotate around the axis of 2.
                
                // Deactivate all the current pieces
                board.blocks_grid[x1][y1].deactivate();
                board.blocks_grid[x2][y2].deactivate();
                board.blocks_grid[x3][y3].deactivate();
                board.blocks_grid[x4][y4].deactivate();
                
                // // 1 has to move up 1 and right 1
                // x1 += 1;
                // y1 -= 1;
    
                // // Skip 2. 3 has to move down 1 and left 1
                // x3 -= 1;
                // y3 += 1;
    
                // // 4 has to move down 2 and left 2
                // x4 -= 2;
                // y2 += 2;
    
                            // 1 has to move up 1 and right 1
                new_x1 = x1 + 1;
                new_y1 = y1 - 1;
    
                // Skip 2. 3 has to move down 1 and left 1
                new_x3 = x3 - 1;
                new_y3 = y3 += 1;
    
                // 4 has to move down 2 and left 2
                new_x4 = x4 - 2;
                new_y2 = y2 + 2; // Okay, this is weird. This works. If I 'correct' it to y4, the piece breaks instead of rotating. In the interest of my sanity, I'm leaving it like this.
                new_x2 = x2;
                new_y4 = y4;
                //new_y2 = y2; // COMMENT THIS OUT WHEN DONE. Also re-mess-up the previous commented line
                if(board.blocks_grid[new_x1][new_y1].is_not_active() && board.blocks_grid[new_x2][new_y2].is_not_active() && board.blocks_grid[new_x3][new_y3].is_not_active() && board.blocks_grid[new_x4][new_y4].is_not_active()){
                  x1 = new_x1;
                  x2 = new_x2;
                  x3 = new_x3;
                  x4 = new_x4;
    
                  y1 = new_y1;
                  y2 = new_y2;
                  y3 = new_y3;
                  y4 = new_y4;
                }
    
                // Activate all the current blocks.
                board.blocks_grid[x1][y1].activate();
                board.blocks_grid[x2][y2].activate();
                board.blocks_grid[x3][y3].activate();
                board.blocks_grid[x4][y4].activate();
    
                // Now update the orientation to reflect the piece's new tallness
                orientation = 1;
              }
            }
          }
          else if(orientation == 1){ // if it's currently tall
            if(x1 > 0 && x1 < 7 && y1 > 1 && y1 < 18 ){ // Makes sure there's actually space to rotate.
              if(board.blocks_grid[x1-1][y1+3].is_not_active() && board.blocks_grid[x3+1][y3+1].is_not_active() && board.blocks_grid[x4+2][y4+2].is_not_active()){ // it can't overlap into other pieces
                // Deactivate all the current pieces
                board.blocks_grid[x1][y1].deactivate();
                board.blocks_grid[x2][y2].deactivate();
                board.blocks_grid[x3][y3].deactivate();
                board.blocks_grid[x4][y4].deactivate();
    
                // 1 has to move left 1 and down 3
                new_x1 = x1 - 1;
                new_y1 = y1 + 3;
    
                // 2 stays stable. 3 moves down 1 and right 1
                new_x3 = x3 + 1;
                new_y3 = y3 + 1;
    
                // 4 moves 2 right and 2 up
                new_x4 = x4 + 2;
                new_y4 = y4 + 2;
    
                new_x2 = x2;
                new_y2 = y2;
    
                if(board.blocks_grid[new_x1][new_y1].is_not_active() && board.blocks_grid[new_x2][new_y2].is_not_active() && board.blocks_grid[new_x3][new_y3].is_not_active() && board.blocks_grid[new_x4][new_y4].is_not_active()){
                  x1 = new_x1;
                  x2 = new_x2;
                  x3 = new_x3;
                  x4 = new_x4;
    
                  y1 = new_y1;
                  y2 = new_y2;
                  y3 = new_y3;
                  y4 = new_y4;
                }
                // Activate all the current blocks.
                board.blocks_grid[x1][y1].activate();
                board.blocks_grid[x2][y2].activate();
                board.blocks_grid[x3][y3].activate();
                board.blocks_grid[x4][y4].activate(); // Out of Bounds Exception occurs here sometimes SOLVED :D it was an issue with the x-bounds.
    
                // Now update the orientation to reflect the piece's new tallness
                orientation = 0;
              }
            } 
          }
        }
        break;
      case 1:
        break;
    }
  } // end of the rotate function. Phew!
  
  void slide_left(Board board){
    if(moving){
      if(x1 > 0 && x2 >0 && x3 > 0 && x4 > 0){ // i.e there IS a left to slide to,
        // Deactivate all the current pieces
        board.blocks_grid[x1][y1].deactivate(); // Out of Bounds Exception Occurs here sometimes AAAND ALSO SOLVED! :D
        board.blocks_grid[x2][y2].deactivate();
        board.blocks_grid[x3][y3].deactivate();
        board.blocks_grid[x4][y4].deactivate();
        int new_x1, new_x2, new_x3, new_x4;
        // decrement every x
        new_x1 = x1 - 1;
        new_x2 = x2 - 1;
        new_x3 = x3 - 1;
        new_x4 = x4 - 1;

        if(board.blocks_grid[new_x1][y1].is_not_active() && board.blocks_grid[new_x2][y2].is_not_active() && board.blocks_grid[new_x3][y3].is_not_active() && board.blocks_grid[new_x4][y4].is_not_active()){
          x1 = new_x1;
          x2 = new_x2;
          x3 = new_x3;
          x4 = new_x4;
        }

        // Activate all the current blocks.
        board.blocks_grid[x1][y1].activate();
        board.blocks_grid[x2][y2].activate();
        board.blocks_grid[x3][y3].activate();
        board.blocks_grid[x4][y4].activate();

      }
    }
  }

  void slide_right(Board board){
    if(moving){
      if(x1 < 9 && x2 < 9 && x3 < 9 && x4 < 9){ // i.e there IS a right to slide to,
        // Deactivate all the current pieces
        board.blocks_grid[x1][y1].deactivate();
        board.blocks_grid[x2][y2].deactivate();
        board.blocks_grid[x3][y3].deactivate();
        board.blocks_grid[x4][y4].deactivate();

        int new_x1, new_x2, new_x3, new_x4;
        // increment every x
        new_x1 = x1 + 1;
        new_x2 = x2 + 1;
        new_x3 = x3 + 1;
        new_x4 = x4 + 1;


        if(board.blocks_grid[new_x1][y1].is_not_active() && board.blocks_grid[new_x2][y2].is_not_active() && board.blocks_grid[new_x3][y3].is_not_active() && board.blocks_grid[new_x4][y4].is_not_active()){
          x1 = new_x1;
          x2 = new_x2;
          x3 = new_x3;
          x4 = new_x4;
        }
        // Activate all the current blocks.
        board.blocks_grid[x1][y1].activate();
        board.blocks_grid[x2][y2].activate();
        board.blocks_grid[x3][y3].activate();
        board.blocks_grid[x4][y4].activate();

      }
    }
  }
  
  void update_lines(Board board){ // Count how many rows on the board are filled. If it's more than the last cycle, move all rows up
    if(!moving){
      for(int a = board.lowest_filled_row + 1; a < board.y_size; a++){
        if(board.line_is_full(a)){
          board.lowest_filled_row = a-1;
          for(int i = 0; i < board.y_size - 1; i++){
            for(int j = 0; j < board.x_size; j++){
              if(board.blocks_grid[j][i+1].is_active()){
                board.blocks_grid[j][i].activate();
              }
              else if(board.blocks_grid[j][i+1].is_not_active()){
                board.blocks_grid[j][i].deactivate();
              }
              // change the state of the current block to match the block below it
              
            }
          } 
        }
      }
    }
  }

}