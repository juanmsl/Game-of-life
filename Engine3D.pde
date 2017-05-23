public class Engine3D extends Engine {
  public int is[] = {-1,-1,-1, 0, 0, 0, 1, 1, 1,-1,-1,-1, 0, 0, 1, 1, 1,-1,-1,-1, 0, 0, 0, 1, 1, 1};
  public int js[] = {-1, 0, 1,-1, 0, 1,-1, 0, 1,-1, 0, 1,-1, 1,-1, 0, 1,-1, 0, 1,-1, 0, 1,-1, 0, 1};
  public int ks[] = {-1,-1,-1,-1,-1,-1,-1,-1,-1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1};
  public int tam;
  
  public Engine3D(int tam, Drawer drawer, boolean limits) {
    super(drawer, limits);
    this.tam = tam + 2;
  }
  
  public void init(int n) {
    board = new boolean[tam][tam][tam];
    for(int i = 1; i < tam - 1; i++) {
      for(int j = 1; j < tam - 1; j++) {
        for(int k = 1; k < tam - 1; k++) {
          setCell(board, i, j, k, (i + j + k) % n == 0);
        }
      }
    }
  }
  
  public void setCell(boolean b[][][], int i, int j, int k, boolean value) {
    if(limits) {
      int ic = -1, jc = -1, kc = -1;
      if(i == 1) {
        b[tam - 1][j][k] = value;
        ic = tam - 1;
      } else if(i == (tam - 1)) {
        b[0][j][k] = value;
        ic = 0;
      }
      
      if(j == 1) {
        b[i][tam - 1][k] = value;
        jc = tam - 1;
      } else if(j == (tam - 1)) {
        b[i][0][k] = value;
        jc = 0;
      }
      
      if(k == 1) {
        b[i][j][tam - 1] = value;
        kc = tam - 1;
      } else if(k == (tam - 1)) {
        b[i][j][0] = value;
        kc = 0;
      }
      
      if(ic != -1 && jc != -1 && kc != -1) {
        b[ic][jc][kc] = value;
      }
    }
    b[i][j][k] = value;
  }
  
  public void nextIteration() {
    boolean next[][][] = new boolean[tam][tam][tam];
    for(int i = 1; i < tam - 1; i++) {
      for(int j = 1; j < tam - 1; j++) {
        for(int k = 1; k < tam - 1; k++) {
          setCell(next, i, j, k, evaluateCell(i, j, k));
        }
      }
    }
    board = next;
  }
  
  public boolean evaluateCell(int i, int j, int k) {
    int count = 0;
    for(int index = 0; index < 26; index++) {
      if(board[i + is[index]][j + js[index]][k + ks[index]]) {
        count++;
      }
    }
    if(board[i][j][k]) {
      return count == 5 || count == 6;
    } else {
      return count == 5;
    }
  }
  
  public void changeCell(int i, int j, int k) {
    boolean value = board[i][j][k];
    setCell(board, i, j, k, !value);
  }
  
  public void resetBoard() {
    for(int i = 0; i < tam; i++) {
      for(int j = 0; j < tam; j++) {
        for(int k = 0; k < tam; k++) {
          board[i][j][k] = false;
        }
      }
    }
  }
  
  public void setLimits(boolean limits) {
    this.limits = limits;
  }
  
  public void drawMesh(int size) {
    float total = (tam - 2) * (tam - 2) * (tam - 2);
    float count = 0;
    float pass = 360.0f / total;
    colorMode(HSB, 360, 100, 100);
    for(int i = 1; i < tam - 1; i++) {
      for(int j = 1; j < tam - 1; j++) {
        for(int k = 1; k < tam - 1; k++) {
          if(board[i][j][k]) {
            this.drawer.drawFillBox(i - 1, j - 1, k - 1, size, color(pass * count, 100, 50, 150));
          }
          count++;
        }
      }
    }
    colorMode(RGB, 255,255,255);
  }
}