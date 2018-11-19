class Rules {
  boolean diagonalMulti(int ox, int oy, int nx, int ny) {
    int xdiff = Math.abs(ox-nx);
    int ydiff = Math.abs(oy-ny);
    if (xdiff==ydiff) {
      return true;
    }
    return false;
  }

  String[] diagonalMultiPath(int ox, int oy, int nx, int ny) {
    int xdiff = nx-ox;
    int ydiff = ny-oy;
    //x and y will have seperate inxcrements depending on individual differences
    int incx = xdiff>0?1:-1;
    int ix = incx;
    int incy = ydiff>0?1:-1;
    int iy = incy;
    String path[] = new String[Math.abs(xdiff)];
    int p=0;
    while (p<Math.abs(xdiff)) {
      path[p] = (Integer.toString((ox+incx))+Integer.toString((oy+incy)));
      incx+=ix;
      incy+=iy;
      p++;
    }
    return path;
  }
  boolean verticalMulti(int ox, int oy, int nx, int ny) {
    if (nx-ox==0) {
      return true;
    }
    return false;
  }
  String[] verticalMultiPath(int ox, int oy, int nx, int ny) {
    int ydiff = ny-oy;
    //x and y will have seperate inxcrements depending on individual differences
    int incy = ydiff>0?1:-1;
    int iy = incy;
    String path[] = new String[Math.abs(ydiff)];
    int p=0;
    while (p<Math.abs(ydiff)) {
      path[p] = (Integer.toString(ox)+Integer.toString((oy+incy)));
      incy+=iy;
      p++;
    }
    return path;
  }

  boolean horizontalMulti(int ox, int oy, int nx, int ny) {
    if (ny-oy==0) {
      return true;
    }
    return false;
  }
  String[] horizontalMultiPath(int ox, int oy, int nx, int ny) {
    int xdiff = nx-ox;
    //x and y will have seperate inxcrements depending on individual differences
    int incx = xdiff>0?1:-1;
    int ix = incx;
    String path[] = new String[Math.abs(xdiff)];
    int p=0;
    while (p<Math.abs(xdiff)) {
      path[p] = (Integer.toString((ox+incx))+Integer.toString(oy));
      incx+=ix;
      p++;
    }
    return path;
  }
  boolean jumpL(int ox, int oy, int nx, int ny) {
    int xdiff = Math.abs(ox-nx);
    int ydiff = Math.abs(oy-ny);
    if (xdiff==1 && ydiff==2) {
      return true;
    }
    if (xdiff==2 && ydiff==1) {
      return true;
    }
    return false;
  }

  boolean omniOne(int ox, int oy, int nx, int ny) {
    int xdiff = Math.abs(ox-nx);
    int ydiff = Math.abs(oy-ny);
    if (xdiff==1 && ydiff==0) {
      return true;
    }
    if (xdiff==0 && ydiff==1) {
      return true;
    }
    if (xdiff==1 && ydiff==1) {
      return true;
    }
    return false;
  }

  boolean bottomUp(int ox, int oy, int nx, int ny) {
    int ydiff = oy-ny;
    int xdiff = nx-ox;
    if (ydiff==1 && xdiff==0) {
      return true;
    }
    return false;
  }
  boolean topDown(int ox, int oy, int nx, int ny) {
    int ydiff = oy-ny;
    int xdiff = nx-ox;
    if (ydiff==-1 && xdiff==0) {
      return true;
    }
    return false;
  }
  boolean bottomUp2(int ox, int oy, int nx, int ny) {
    int ydiff = oy-ny;
    int xdiff = nx-ox;
    if (ydiff==2 && xdiff==0) {
      return true;
    }
    return false;
  }
  boolean topDown2(int ox, int oy, int nx, int ny) {
    int ydiff = oy-ny;
    int xdiff = nx-ox;
    if (ydiff==-2 && xdiff==0) {
      return true;
    }
    return false;
  }

  boolean pawnAttack(int ox, int oy, int nx, int ny, boolean black) {
    int xdiff = ox-nx;
    int ydiff = oy - ny;
    if (black) {
      if (ydiff== 1 && (xdiff==1||xdiff==-1)) {
        return true;
      }
    } else if (!black) {
      if (ydiff == -1 && (xdiff==1||xdiff==-1)) {
        return true;
      }
    }
    return false;
  }
  boolean diagonalPiece(int ox, int oy, int nx, int ny, Board board, boolean black) {
    int xdiff = (ox-nx);
    int ydiff = (oy-ny);
    if (black) {
      if (board.getPiece(nx, ny)!=null && xdiff==1 && ydiff == 1) {
        if (board.getPiece(nx, ny).black!=black) {
          return true;
        }
      }
    } else if (!black) {
      if (board.getPiece(nx, ny)!=null && xdiff==1 && ydiff == -1) {
        if (board.getPiece(nx, ny).black!=black) {
          return true;
        }
      }
    }
    return false;
  }
  boolean forwardKill(int ox, int oy,String type){
    if(type.equals("PawnB.png")){
      if(board.getPiece(ox,oy-1)!=null){
        return false;
      }
    }
    if(type.equals("PawnW.png")){
      if(board.getPiece(ox,oy+1)!=null){
        return false;
      }
    }
    return true;
  }
  boolean sameOverlap(int nx, int ny, Board board, boolean black) {
    Piece a = board.getPiece(nx, ny);    
    if (a!=null && black==a.black) {
      return true;
    }
    return false;
  }
}
