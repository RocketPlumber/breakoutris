
/*
  The game must contain:
  A BLOCK class. A Block is the most basic element that can go onto the game grid.
  A PIECE class. A Piece is a collection of four blocks that fall together. It takes the form of one of the standard Tetris pieces.
  A GAMEBOARD class. A Game Board is the grid that the main game is played on. The Board is where pieces are in play .
*/

class Block{
  // A block needs to know where it is.
  int grid_x;
  int grid_y;

  // A block needs to know whether to move or not.
  boolean stationary = false;

  // A block needs to be able to move in any direction.
  void move(int move_dir){
  	// move_dir tells the block which way to move.
  	// 1 is up, 2 is left, 3 is right. A block cannot move down.
    switch(move_dir){
      case 1: if(grid_y > 0) {grid_y -= 1;}                   // The grid positions are calculated assuming the Tetris player sits at the bottom of the screen.
          break;                                              // Hence moving 'up' means going to a lower y-value.
      case 2: if(grid_x > 0) {grid_x -= 1;}                   // Similarly for going left. It means going negative-x on the grid
          break;
      case 3: if(grid_x < GBoard.get_width()) {grid_x += 1;}  // GBoard is the Game Board object. get_width returns the int that is the width of the board, in blocks 
    }
  }
}