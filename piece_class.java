class LinePiece{

  // A Line is a Tetris piece made of four blocks in, well, a line.

  // Everything we know about the position of the line will be in relation to one 'anchor piece'.

  // The co-ordinates of all four pieces must be known
  int x1, y1, x2, y2, x3, y3, x4, y4;

  // The status of the block, i.e should it move or should it stay still, must be known.
  boolean moving = true;

  int orientation = 0; // For a line, there's two orientations - 0 means flat and 1 means tall.

  // We initialize a line by knowing its starting x and y. These are usually going to be y = 19 and x = something between 0 and 6.
  // We need to draw it in its original orientation (flat) by setting all occupied squares to be Active.
  LinePiece(int anchor_x, int anchor_y, Board board){
    // x1,y1 is forever the anchor piece
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

    // Now activate all the relevant pieces;
    board[x1][y1].activate();
    board[x2][y2].activate();
    board[x3][y3].activate();
    board[x4][y4].activate();
  }

  

}
