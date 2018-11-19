//Past me to Future me, Have fun trying to make sense of this
//I commend you if you can get a single word
//I just wrote this and I'm reeling from how messed up it is
Board board;
Piece kingB, queenB, knightB1, knightB2, bishopBb, bishopBw, rookW1, rookB2;//Main Black pieces
Piece kingW, queenW, knightW1, knightW2, bishopWb, bishopWw, rookB1, rookW2;//Main White pieces
Piece pawnB1, pawnB2, pawnB3, pawnB4, pawnB5, pawnB6, pawnB7, pawnB8;
Piece pawnW1, pawnW2, pawnW3, pawnW4, pawnW5, pawnW6, pawnW7, pawnW8;
int val = 0;
int scl = 60;
String index="";
Piece picked;
Rules r = new Rules();
;
void setup() {
  size(600, 600);
  board = new Board();
  //black pieces
  kingB = new Piece("KingB.png", "37", board, true);
  queenB = new Piece("QueenB.png", "47", board, true);
  knightB1 = new Piece("KnightB.png", "67", board, true);
  knightB2 = new Piece("KnightB.png", "17", board, true);
  bishopBw = new Piece("BishopB.png", "57", board, true);
  bishopBb = new Piece("BishopB.png", "27", board, true);
  rookB1 = new Piece("RookB.png", "77", board, true);
  rookB2 = new Piece("RookB.png", "07", board, true);
  //pawns
  pawnB1 = new Piece("PawnB.png", "76", board, true);
  pawnB2 = new Piece("PawnB.png", "66", board, true);
  pawnB3 = new Piece("PawnB.png", "56", board, true);
  pawnB4 = new Piece("PawnB.png", "46", board, true);
  pawnB5 = new Piece("PawnB.png", "36", board, true);
  pawnB6 = new Piece("PawnB.png", "26", board, true);
  pawnB7 = new Piece("PawnB.png", "16", board, true);
  pawnB8 = new Piece("PawnB.png", "06", board, true);
  //white pieces
  kingW = new Piece("KingW.png", "30", board, false);
  queenW = new Piece("QueenW.png", "40", board, false);
  knightW1 = new Piece("KnightW.png", "10", board, false);
  knightW2 = new Piece("KnightW.png", "60", board, false);
  bishopWb = new Piece("BishopW.png", "50", board, false);
  bishopWw = new Piece("BishopW.png", "20", board, false);
  rookW1 = new Piece("RookW.png", "70", board, false);
  rookW2 = new Piece("RookW.png", "00", board, false);
  //pawns
  pawnW1 = new Piece("PawnW.png", "71", board, false);
  pawnW2 = new Piece("PawnW.png", "61", board, false);
  pawnW3 = new Piece("PawnW.png", "51", board, false);
  pawnW4 = new Piece("PawnW.png", "41", board, false);
  pawnW5 = new Piece("PawnW.png", "31", board, false);
  pawnW6 = new Piece("PawnW.png", "21", board, false);
  pawnW7 = new Piece("PawnW.png", "11", board, false);
  pawnW8 = new Piece("PawnW.png", "01", board, false);
}

void draw() {
  background(255);
  board.show();

  for (int i=0; i<8; i++) {
    for (int j = 0; j<8; j++) {
      if (board.cells[i][j].onCell!=null) {
        board.cells[i][j].onCell.show();
      }
    }
  }
}

void mousePressed() {
  index = board.getSquare(mouseX, mouseY);
  picked = board.getPiece(index);
}

void mouseReleased() {
  String newindex = board.getSquare(mouseX, mouseY);//gets where the mouse is
  if (picked!=null) {
    int oldx = Integer.parseInt(index.charAt(0)+"");
    int oldy = Integer.parseInt(index.charAt(1)+"");
    int newx = Integer.parseInt(index.charAt(0)+"");
    int newy = Integer.parseInt(index.charAt(1)+"");

    if (checkRules(picked.type, index, newindex, picked.black)) {

      picked.x = Integer.parseInt(newindex.charAt(0)+"");
      picked.y = Integer.parseInt(newindex.charAt(1)+"");

      /*println("Dangerous Move for White King = "+a);
       println("Dangerous Move for Black King = "+b);*/

      board.cells[oldx][oldy].onCell = null;//piece on old cell is removed
      board.cells[picked.x][picked.y].onCell = picked;//now the cell also gets the transferred piece
      checkMate();


      println("White king in danger = " +kingInDanger(true, board));
      println("Black king in danger = " +kingInDanger(false, board));
    }
  }
}

boolean checkRules(String type, String oldi, String newi, boolean black) {
  int oldx = Integer.parseInt(oldi.charAt(0)+"");
  int oldy = Integer.parseInt(oldi.charAt(1)+"");
  int newx = Integer.parseInt(newi.charAt(0)+"");
  int newy = Integer.parseInt(newi.charAt(1)+"");
  boolean ret = false;
  String[] path;
  //Bishop
  if (type!=null) {
    if (type.equals("BishopB.png")||type.equals("BishopW.png")) {
      ret = r.diagonalMulti(oldx, oldy, newx, newy);
      if (ret) {//avoids going through pieces
        path = r.diagonalMultiPath(oldx, oldy, newx, newy);
        ret = board.isPieceOnPath(path, picked.black);
        ret = !ret; //this is there cause the above fuction will return true if there is a piece on the intersecting path
      }
    }
    //Rook
    if (type.equals("RookB.png")||type.equals("RookW.png")) {
      boolean a = r.verticalMulti(oldx, oldy, newx, newy);//rook's moves
      boolean b = r.horizontalMulti(oldx, oldy, newx, newy);
      if (a||b) {
        ret = true;
      }
      if (a) {
        path = r.verticalMultiPath(oldx, oldy, newx, newy);
        ret = board.isPieceOnPath(path, picked.black);
        ret = !ret;
      }
      if (b) {
        path = r.horizontalMultiPath(oldx, oldy, newx, newy);
        ret = board.isPieceOnPath(path, picked.black);
        ret = !ret;
      }
    }
    //Knight
    if (type.equals("KnightB.png")||type.equals("KnightW.png")) {
      ret = r.jumpL(oldx, oldy, newx, newy);//knight's moves
    }
    //King
    if (type.equals("KingB.png")||type.equals("KingW.png")) {
      ret = r.omniOne(oldx, oldy, newx, newy);//king's moves
    }

    //Queen
    if (type.equals("QueenB.png")||type.equals("QueenW.png")) {
      boolean a = r.verticalMulti(oldx, oldy, newx, newy);//queen's moves
      boolean b = r.horizontalMulti(oldx, oldy, newx, newy);
      boolean c = r.diagonalMulti(oldx, oldy, newx, newy);
      if (a||b||c) {
        ret = true;
      }
      if (a) {
        path = r.verticalMultiPath(oldx, oldy, newx, newy);
        ret = board.isPieceOnPath(path, picked.black);
        ret = !ret;
        //printArray(path);
      } else if (b) {
        path = r.horizontalMultiPath(oldx, oldy, newx, newy);
        ret = board.isPieceOnPath(path, picked.black);
        ret = !ret;
        //printArray(path);
      } else if (c) {
        path = r.diagonalMultiPath(oldx, oldy, newx, newy);
        ret = board.isPieceOnPath(path, picked.black);
        ret = !ret; //this is cause the abve fuction will return true if there is a piece on the intersecting path
        //printArray(path);
      }
    }
    //pawn functions
  if(board.getPiece(newx,newy)==null){
    if (type.equals("PawnB.png")&&picked.y<6) {
      ret = r.bottomUp(oldx, oldy, newx, newy); //one space up
    }
    if (type.equals("PawnW.png")&&picked.y>1) {
      ret = r.topDown(oldx, oldy, newx, newy); //one space down
    }
    if (type.equals("PawnB.png") && picked.y==6) {
      ret = r.bottomUp2(oldx, oldy, newx, newy)||r.bottomUp(oldx, oldy, newx, newy); //two spaces up or one space up
      if (ret) {
        path = r.verticalMultiPath(oldx, oldy, newx, newy);
        ret = board.isPieceOnPath(path, picked.black);
        ret = !ret;
        //printArray(path);
      }
    }
    if (type.equals("PawnW.png") && picked.y==1) {
      ret = r.topDown2(oldx, oldy, newx, newy)||r.topDown(oldx, oldy, newx, newy);//two spaces down or one space down
      if (ret) {
        path = r.verticalMultiPath(oldx, oldy, newx, newy);
        ret = board.isPieceOnPath(path, picked.black);
        ret = !ret;
  
        //printArray(path);
      }
    }
  }
  if(board.getPiece(newx,newy)!=null){
    if (type.equals("PawnW.png")||type.equals("PawnB.png")) {
      if (r.pawnAttack(oldx, oldy, newx, newy, black)) {
        ret = true;
      }
    }
  }
   
    if (r.sameOverlap(newx, newy, board, black)) {
      ret = false;
    }
  }
  return ret;
}


boolean kingInDanger(boolean black, Board board) {
  boolean a = false;
  String kingindex;
  //checks if the king is in danger
  for (int i=0; i<board.cells.length; i++) {
    for (int j=0; j<board.cells[i].length; j++) {
      if (board.cells[i][j].onCell!=null) {
        String newindex = Integer.toString(board.cells[i][j].onCell.x)+Integer.toString(board.cells[i][j].onCell.y);
        if (black) {
          kingindex = Integer.toString(kingW.x)+Integer.toString(kingW.y);
        } else {
          kingindex = Integer.toString(kingB.x)+Integer.toString(kingB.y);
        }
        a = checkRules(board.cells[i][j].onCell.type, newindex, kingindex, board.cells[i][j].onCell.black);
        if (a) {
          return a;
        }
      }
    }
  }
  return a;
}
boolean isDangerous(Piece king, int nx, int ny, Piece picked) {
  boolean danger = false;
  for (int i=0; i<board.cells.length; i++) {
    for (int j=0; j<board.cells[i].length; j++) {
      if (board.cells[i][j].onCell!=null && (picked.type.equals(king.type))) {     
        if (board.cells[i][j].onCell.black!=king.black ) {
          int x = board.cells[i][j].onCell.x;
          int y = board.cells[i][j].onCell.y;
          danger = checkRules(board.cells[i][j].onCell.type, (x+""+y), (nx+""+ny), board.cells[i][j].onCell.black);
        }
        if (danger) {
          return danger;
        }
      }
    }
  }
  return danger;
}
boolean isDangerous(Piece king, int nx, int ny) {
  boolean danger = false;
  for (int i=0; i<board.cells.length; i++) {
    for (int j=0; j<board.cells[i].length; j++) {
      if (board.cells[i][j].onCell!=null) {     
        if (board.cells[i][j].onCell.black!=king.black ) {
          int x = board.cells[i][j].onCell.x;
          int y = board.cells[i][j].onCell.y;
          danger = checkRules(board.cells[i][j].onCell.type, (x+""+y), (nx+""+ny), board.cells[i][j].onCell.black);
          if (danger) {
            return danger;
          }
        }
      }
    }
  }
  return danger;
}
Piece kingInDanger(boolean black, int b) {
  boolean a = false;
  String kingindex;
  //checks if the king is in danger
  for (int i=0; i<board.cells.length; i++) {
    for (int j=0; j<board.cells[i].length; j++) {
      if (board.cells[i][j].onCell!=null) {
        String newindex = Integer.toString(board.cells[i][j].onCell.x)+Integer.toString(board.cells[i][j].onCell.y);
        if (black) {
          kingindex = Integer.toString(kingW.x)+Integer.toString(kingW.y);
        } else {
          kingindex = Integer.toString(kingB.x)+Integer.toString(kingB.y);
        }
        a = checkRules(board.cells[i][j].onCell.type, newindex, kingindex, board.cells[i][j].onCell.black);
        if (a) {
          return board.cells[i][j].onCell;
        }
      }
    }
  }
  return null;
}

void checkMate() {
  //can any piece come inbetween the dangerous piece and the king?
  //can any piece kill the dangerous piece?
  //can the king move anywhere else?

  //1. can a piece come in between?
  //white piece if white king is in danger
  boolean  whiteKing = kingInDanger(true, board);
  boolean  blackKing = kingInDanger(false, board);
  println("Whiteking = "+whiteKing);
  println("Blackking = "+blackKing);
  Piece offending = null;
  if (whiteKing) {
    offending = kingInDanger(true, 1);
  } else if (blackKing) {
    offending = kingInDanger(false, 1);
  }
  //get the path the piece will follow
  String[] path = {};
  boolean kingtype = false;
  //---------
  if (offending!=null) {//attacking pieces will be black
    if (offending.type.equals("BishopB.png")) {      
      path = r.diagonalMultiPath(offending.x, offending.y, kingW.x, kingW.y); //diagonal path for bishop
      kingtype = false;
    } else if (offending.type.equals("BishopW.png")) {        
      path = r.diagonalMultiPath(offending.x, offending.y, kingB.x, kingB.y);
      kingtype = true;
    } else if (offending.type.equals("RookB.png")) {
      boolean a = r.verticalMulti(offending.x, offending.y, kingW.x, kingW.y);//rook's moves
      boolean b = r.horizontalMulti(offending.x, offending.y, kingW.x, kingW.y);//gets the type of moves it will make
      if (a) {
        path = r.verticalMultiPath(offending.x, offending.y, kingW.x, kingW.y); //gets the path followed
      }
      if (b) {
        path = r.horizontalMultiPath(offending.x, offending.y, kingW.x, kingW.y);
      }
      kingtype = false;
    } else if (offending.type.equals("RookW.png")) {
      boolean a = r.verticalMulti(offending.x, offending.y, kingB.x, kingB.y);//rook's moves
      boolean b = r.horizontalMulti(offending.x, offending.y, kingB.x, kingB.y);//gets the type of moves it will make
      if (a) {
        path = r.verticalMultiPath(offending.x, offending.y, kingB.x, kingB.y); //gets the path followed
      }
      if (b) {
        path = r.horizontalMultiPath(offending.x, offending.y, kingB.x, kingB.y);
      }
      kingtype = true;
    } else if (offending.type.equals("QueenB.png")) {
      boolean a = r.verticalMulti(offending.x, offending.y, kingW.x, kingW.y);//Queen's moves
      boolean b = r.horizontalMulti(offending.x, offending.y, kingW.x, kingW.y);//gets the type of moves it will make
      boolean c = r.diagonalMulti(offending.x, offending.y, kingW.x, kingW.y);
      if (a) {
        path = r.verticalMultiPath(offending.x, offending.y, kingW.x, kingW.y); //gets the path followed
      }
      if (b) {
        path = r.horizontalMultiPath(offending.x, offending.y, kingW.x, kingW.y);
      }
      if (c) {
        path = r.diagonalMultiPath(offending.x, offending.y, kingW.x, kingW.y);
      }
      kingtype = false;
    } else if (offending.type.equals("QueenW.png")) {
      boolean a = r.verticalMulti(offending.x, offending.y, kingB.x, kingB.y);//rook's moves
      boolean b = r.horizontalMulti(offending.x, offending.y, kingB.x, kingB.y);//gets the type of moves it will make
      boolean c = r.diagonalMulti(offending.x, offending.y, kingB.x, kingB.y);
      if (a) {
        path = r.verticalMultiPath(offending.x, offending.y, kingB.x, kingB.y); //gets the path followed
      }
      if (b) {
        path = r.horizontalMultiPath(offending.x, offending.y, kingB.x, kingB.y);
      }
      if (c) {
        path = r.diagonalMultiPath(offending.x, offending.y, kingB.x, kingB.y);
      }
      kingtype = true;
    }
    boolean possible = false;
    boolean blockable = false;
    //check if any white piece can occupy any position on the path
    for (int i=0; i<path.length; i++) {
      for (int j=0; j<board.cells.length; j++) {
        for (int k =0; k<board.cells[j].length; k++) {
          if (board.cells[j][k].onCell!=null) {
            int ox = board.cells[j][k].onCell.x;
            int oy = board.cells[j][k].onCell.y;
            if (board.cells[j][k].onCell.black==kingtype && (!board.cells[j][k].onCell.type.equals("KingB.png")&&!board.cells[j][k].onCell.type.equals("KingW.png"))) { 
              possible = checkRules(board.cells[j][k].onCell.type, (ox+""+oy), path[i], board.cells[j][k].onCell.black);
              if (possible) {
                print("Blockable by "+board.cells[j][k].onCell.type+" ");
                blockable = true;
              }
            }
          }
        }
      }
    }
    //--------


    //can the piece be killed?
    boolean killable = false;
    for (int j=0; j<board.cells.length; j++) {
      for (int k =0; k<board.cells[j].length; k++) {
        if (board.cells[j][k].onCell!=null) {
          int ox = board.cells[j][k].onCell.x;
          int oy = board.cells[j][k].onCell.y;
          if (board.cells[j][k].onCell.black==kingtype) {
            possible = checkRules(board.cells[j][k].onCell.type, (ox+""+oy), offending.x+""+offending.y, board.cells[j][k].onCell.black);

            if (possible) {

              print("Killable by "+board.cells[j][k].onCell.type+" ");
              killable = true;
            }
          }
        }
      }
    }
    //can the king be moved anywhere to escape?
    boolean safe = false;
    if (whiteKing) {
      for (int j=0; j<board.cells.length; j++) {
        for (int k=0; k<board.cells[j].length; k++) {
          if (board.cells[j][k].onCell==null) {
            int x = j;
            int y = k;
            boolean move = checkRules(kingW.type, (kingW.x+""+kingW.y), (x+""+y), kingW.black);
            if (move) {
              if (!isDangerous(kingW, x, y)) {
                print("a");
                safe = true;
              }
            }
          }
        }
      }
    } 
    if (blackKing) {
      for (int j=0; j<board.cells.length; j++) {
        for (int k=0; k<board.cells[j].length; k++) {
          if (board.cells[j][k].onCell==null) {
            int x = j;
            int y = k;
            boolean move = checkRules(kingB.type, (kingB.x+""+kingB.y), (x+""+y), kingB.black);
            if (move) {
              if (!isDangerous(kingB, x, y, kingB)) {
                print("a");
                safe = true;
              }
            }
          }
        }
      }
    }
    println("Safe ? = "+safe);
    println("killable ? = "+killable);
    println("blockable ? = "+blockable);
    if (!safe && !killable && !blockable) {
      println("....Checkmate....");
    }
  }
}
