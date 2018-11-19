class Piece {
  String type;
  String index;
  int x, y;
  boolean black;
  PImage image;
  
  Piece(String type_, String index_,Board board,boolean black_) {
    type = type_;
    index = index_;
    x = Integer.parseInt(index.charAt(0)+"");
    y = Integer.parseInt(index.charAt(1)+"");
    black = black_;
    board.cells[x][y].onCell = this;
  }

  void show() {
    index = Integer.toString(x)+Integer.toString(y);
    image = loadImage(type);
    image.resize(scl,scl);
    image(image, x*scl, (y)*scl);
  }
}
