public abstract class Engine {
  protected boolean board[][][];
  protected boolean limits;
  protected int size;
  protected Drawer drawer;
  
  public Engine(int size, Drawer drawer, boolean limits) {
    this.drawer = drawer;
    this.size = size;
    this.limits = limits;
  }
  
  public abstract void init(int n);
  public abstract void nextIteration();
  public abstract void drawMesh();
  public abstract void resetBoard();
  public abstract void setLimits(boolean limits);
}