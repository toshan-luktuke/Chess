class Board {
  int x = 8;
  int y = 8;
  Cell[][] cells = new Cell[x][y];
  Board() {
    //initializes and displays the board
    boolean black;
    int p = 1;
    for (int i=0; i<cells.length; i++) {
      for (int j=0; j<cells[i].length; j++) {
        if (p%2==0) {
          black = true;
        } else {
          black = false;
        }
        cells[i][j] = new Cell(i, j, black);
        p++;
      }
      p++;
    }
  }
  boolean isPieceOnPath(String[] path, boolean black) {
    for (int i =0; i<path.length; i++) {
      String st = path[i];
      Piece pc = getPiece(st);
      if (pc!=null && i!=path.length-1) {
        return true; //if there's a piece in the way, then don't allow the original to move
      }
    }
    return false;
  }
  
  Piece getPiece(String index) {
    int a = Integer.parseInt(index.charAt(0)+"");
    int b = Integer.parseInt(index.charAt(1)+"");
    if (b>=8) {
      b=7;
    }
    return cells[a][b].onCell;//returns the piece on that index
  }
  Piece getPiece(int a, int b) {
    if (b>=8) {
      b=7;
    }
    return cells[a][b].onCell;//returns the piece on that index
  }

  String getSquare(int mousex, int mousey) {
    //get the index of the square over which the mouse hovers
    int retx = mousex/scl;
    int rety = mousey/scl;

    if (retx>=8) {
      retx = 7;
    }
    if (rety>=8) {
      rety = 7;
    }

    return Integer.toString(retx)+Integer.toString(rety);
  }


  void show() {
    for (int i=0; i<cells.length; i++) {
      for (int j=0; j<cells[i].length; j++) {
        cells[j][i].show();
      }
    }
  }
}


class Cell {
  String index;
  int x, y;
  boolean black;
  Piece onCell;

  Cell(int x_, int y_, boolean black_, Piece piece) {
    onCell = piece;
    x = x_;
    y = y_;
    black = black_;
  }

  Cell(int x_, int y_, boolean black_) {
    x = x_;
    y = y_;
    black = black_;
  }

  void show() {
    if (black) {
      fill(120);
    } else {
      fill(255);
    }
    String index = Integer.toString(x)+Integer.toString(y);
    rect((x*scl), (y*scl), scl, scl);
    fill(30);
    textSize(10.0);
    text(index, (x*scl)+1, ((y+1)*scl)-1);
    //multiplies by 0, so the number wasn't being displayed
  }
}
