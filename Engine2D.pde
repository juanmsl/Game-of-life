public class Engine2D extends Engine {
  
  public int is[] = {-1,-1,-1, 0, 0, 1, 1, 1};
  public int js[] = {-1, 0, 1,-1, 1,-1, 0, 1};
  public int w;
  public int h;
  public boolean mesh;
  
  public Engine2D(String pattern, int w, int h, Drawer drawer, boolean limits, boolean mesh) {
    super(pattern, drawer, limits);
    this.w = w + 2;
    this.h = h + 2;
    this.mesh = mesh;
  }
  
  public void init(int n) {
    board = new boolean[w][h][1];
    for(int i = 1; i < w - 1; i++) {
      for(int j = 1; j < h - 1; j++) {
        setCell(board, i, j, (i + j) / n % 2 == 0);
      }
    }
  }
  
  public void setCell(boolean b[][][], int i, int j, boolean value) {
    if(limits) {
      int ic = -1, jc = -1;
      if(i == 1) {
        b[w - 1][j][0] = value;
        ic = w - 1;
      } else if(i == (w - 2)) {
        b[0][j][0] = value;
        ic = 0;
      }
      
      if(j == 1) {
        b[i][h - 1][0] = value;
        jc = h - 1;
      } else if(j == (h - 2)) {
        b[i][0][0] = value;
        jc = 0;
      }
      
      if(ic != -1 && jc != -1) {
        b[ic][jc][0] = value;
      }
    }
    b[i][j][0] = value;
  }
  
  public void nextIteration() {
    boolean next[][][] = new boolean[w][h][1];
    for(int i = 1; i < w - 1; i++) {
      for(int j = 1; j < h - 1; j++) {
        setCell(next, i, j, evaluateCell(i, j));
      }
    }
    board = next;
  }
  
  public boolean evaluateCell(int i, int j) {
    int count = 0;
    for(int index = 0; index < 8; index++) {
      if(board[i + is[index]][j + js[index]][0]) {
        count++;
      }
    }
    boolean result = false;
    if(board[i][j][0]) {
      for(int p = 0; p < alive.length; p++) {
        result |= count == alive[p];
      }
    } else {
      for(int p = 0; p < born.length; p++) {
        result |= count == born[p];
      }
    }
    return result;
  }
  
  public void changeCell(int i, int j) {
    boolean value = board[i][j][0];
    setCell(board, i, j, !value);
  }
  
  public void resetBoard() {
    for(int i = 0; i < w; i++) {
      for(int j = 0; j < h; j++) {
        board[i][j][0] = false;
      }
    }
  }
  
  public void setMesh(boolean mesh) {
    this.mesh = mesh;
  }
  
  public void setLimits(boolean limits) {
    this.limits = limits;
  }
  
  public void drawMesh(int size) {
    float total = (w - 2) * (h - 2);
    float count = 0;
    float pass = 360.0f / total;
    colorMode(HSB, 360, 100, 100);
    for(int i = 1; i < w - 1; i++) {
      for(int j = 1; j < h - 1; j++) {
        if(board[i][j][0]) {
          this.drawer.drawFillRect(i - 1, j - 1, size, size, color(pass * count, 100, 50));
        } else if(mesh) {
          this.drawer.drawEmptyRect(i - 1, j - 1, size, size);
        }
        count++;
      }
    }
    colorMode(RGB, 255,255,255);
  }
}