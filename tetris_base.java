


// READ THIS FIRST:
// I'm only gone for a couple of minutes, please do not use this terminal. Thank you! :)







/*
  The game must contain:
  A BLOCK class. A Block is the most basic element that can go onto the game grid.
  A PIECE class. A Piece is a collection of four blocks that fall together. It takes the form of one of the standard Tetris pieces.
  A GAMEBOARD class. A Game Board is the grid that the main game is played on. The Board is where pieces are in play.
    A set of Game Board co-ordinates represents a BLOCK position, and NOT a pixel position. So 0,0 is the top-right-most BLOCK, not the top right pixel.
    0,1 is the next block to the right, and so on.
*/

class Block{
  // A Block needs to know where it is on the grid.
  int grid_x;
  int grid_y;

  // A Block needs to know whether to move or not.
  boolean stationary = false;


  // To be a Block, a Block must first initialize its own existence.
  Block(int start_x, int start_y){
    grid_x = start_x;
    grid_y = start_y;
  }


  // A block needs to be able to move in any direction.
  void move(int move_dir){
  	// move_dir tells the block which way to move.
  	// 1 is up, 2 is left, 3 is right. A block cannot move down.
    switch(move_dir){
      case 1: 
        if(grid_y > 0) {grid_y -= 1;}                   // The grid positions are calculated assuming the Tetris player sits at the bottom of the screen.
        break;                                          // Hence moving 'up' means going to a lower y-value.
      case 2: 
        if(grid_x > 0) {grid_x -= 1;}                   // Similarly for going left. It means going to a lower x on the grid.
        break;
      case 3: 
        if(grid_x < GBoard.get_width()) {grid_x += 1;}  // GBoard is the Game Board object. get_width returns the int that is the width of the board, in blocks.
        break; 
    }
  }

  void display(){
    /* 
    Currently leaving this blank, because there are two ways of doing this:
      EITHER I can have it so that there's a bunch of blocks moving, and the main game has an array of them.
      New Tetris piece in play adds a new block to the game. A ball hit will remove delete the block.

      OR I can have it such that the Grid is actually a collection of blocks
      And each block will have the property of being Occupied or Unoccupied
      So when a block is Occupied it lights up
      And when it slots into place it stops moving.
    */
  } 
}
