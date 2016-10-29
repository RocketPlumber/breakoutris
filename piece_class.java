class LinePiece{

  // A Line is a Tetris piece made of four blocks in, well, a line.

  // Everything we know about the position of the line will be in relation to one 'anchor piece'.

  // The co-ordinates of all four pieces must be known
  int x1, y1, x2, y2, x3, y3, x4, y4;

  // The status of the block, i.e should it move or should it stay still, must be known.
  boolean moving = true;

  // We initialize a line by knowing its starting x and y. These are usually going to be y = 20 and x = something between 0 and 8. A line enters the screen all flat-like.
  LinePiece(int anchor_x, int anchor_y, Board board){

  }

}