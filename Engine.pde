import java.util.StringTokenizer;

public abstract class Engine {
  protected boolean board[][][];
  protected boolean limits;
  protected Drawer drawer;
  protected int alive[];
  protected int born[];
  
  public Engine(String pattern, Drawer drawer, boolean limits) {
    this.drawer = drawer;
    this.limits = limits;
    
    StringTokenizer token = new StringTokenizer(pattern, "/");
    String alivePattern = token.nextToken();
    String bornPattern = token.nextToken();
    alive = new int[alivePattern.length()];
    born = new int[bornPattern.length()];
    for(int i = 0; i < alivePattern.length(); i++) {
      alive[i] = Integer.parseInt(alivePattern.charAt(i) + "");
    }
    for(int i = 0; i < bornPattern.length(); i++) {
      born[i] = Integer.parseInt(bornPattern.charAt(i) + "");
    }
  }
  
  public abstract void init(int n);
  public abstract void nextIteration();
  public abstract void drawMesh(int size);
  public abstract void resetBoard();
  public abstract void setLimits(boolean limits);
}