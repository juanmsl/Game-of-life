public class Drawer {
  public color blanco = color(255,255,255);
  public color negro = color(0,0,0);
  
  public Drawer() {}
  
  public void drawFillRect(int i, int j, int w, int h) {
    fill(blanco);
    stroke(negro);
    rect((i * w), (j * h), w, h);
  }
  
  public void drawEmptyRect(int i, int j, int w, int h) {
    noFill();
    stroke(blanco);
    rect((i * w), (j * h), w, h);
  }
  
  public void drawFillBox(int i, int j, int k, int size, color c) {
    pushMatrix();
    fill(c);
    stroke(negro);
    translate(i * size, j * size, k * size);
    box(size);
    popMatrix();
  }
  
  public void drawEmptyBox(int i, int j, int k, int size) {
    pushMatrix();
    noFill();
    stroke(blanco);
    translate(i * size, j * size, k * size);
    box(size);
    popMatrix();
  }
}