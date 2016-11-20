class Board{

  // The Board needs to have a size in two dimensions, as well as a 2D array of blocks
  int x_size, y_size;
  Block[][] blocks_grid;
  color p_col = color(255, 0, 0); // defaulting to red right now, the current color solution is a temporary workaround.
  Board(int x_blocks=10, int y_blocks = 20){

    x_size = x_blocks;
    y_size = y_blocks;

    blocks_grid = new Block[x_size][y_size]; // Initialize the grid of Blocks that form the main structure of the board.

    for(int i = 0; i < x_size;i++){
      for(int j = 0; j < y_size; j++){
        blocks_grid[i][j] = new Block(i, j);
      }
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


}
