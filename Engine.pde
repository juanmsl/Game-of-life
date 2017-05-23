public abstract class Engine {
  protected boolean board[][][];
  protected boolean limits;
  protected Drawer drawer;
  
  public Engine(Drawer drawer, boolean limits) {
    this.drawer = drawer;
    this.limits = limits;
  }
  
  public abstract void init(int n);
  public abstract void nextIteration();
  public abstract void drawMesh(int size);
  public abstract void resetBoard();
  public abstract void setLimits(boolean limits);
}