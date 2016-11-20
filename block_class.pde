// Society values uniformity in Blocks. Hence, the proper size of a Block is GLOBALly known and accepted.
int b_size = 40; // This is, of course, subject to society's whims. Should the norm change, this value will change to reflect that. (How many pixels long is a side)


// Let us now delve into the basest essence of what makes a Block, a Block.
class Block{

  // A Block must know where it belongs.
  int x_coor, y_coor;

  // A Block must know whether it's occupied or not.
  boolean active = false;


  // A Block must have some method of coming to be.
  Block(int x, int y){
    x_coor = x;
    y_coor = y;

  }

  // A Block musn't be afraid of presenting itself to the world.
  void display(color b_color){
    if(active){
      fill(b_color);
      image(block_pic, print_offset_x + x_coor*b_size, print_offset_y + y_coor*b_size, b_size, b_size);
    }
    else if(!active){
      fill(255);
      rect(print_offset_x + x_coor*b_size, print_offset_y + y_coor*b_size, b_size, b_size);
    }
  }
  // A Block must have some way to be activated when there's a piece in it.
  void activate(){
    active = true;
  }

  // A Block must have some way of knowing it should hide when there is no longer a piece in it.
  void deactivate(){
    active = false;
  }

  boolean is_active(){
    return(active);
  }

  boolean is_not_active(){
    return(!active);
  }
  int corner_x(){
    int temp = 0;
    temp += x_coor*b_size;
    temp += print_offset_x;
    return temp;
  }
  
  int corner_y(){
    int temp = 0;
    temp += y_coor*b_size;
    temp += print_offset_y;
    return temp;
  }
  // And that, my friends, is what it means to be a Block.
} 