import controlP5.*;

ControlP5 cp5;

int size = 2;
int w = 850;
int h = 400;
int tam = 100;
int value = 3;
boolean play = true;
boolean mesh = false;
boolean limits = true;
boolean is3D = false;

int px = 0, py = 0;
float rotX = 0;
float rotY = 0;
int framerate = 30;

Drawer drawer;
Engine engine;

void setup() {
  size(1700, 900, P3D);
  cp5 = new ControlP5(this);
  cp5.addSlider("size")
       .setPosition(0, 0)
       .setSize(1700, 20)
       .setRange(1, 15)
       .setValue(size)
       .setColorCaptionLabel(color(20,20,20));
  drawer = new Drawer();
  if(is3D) {
   engine = new Engine3D(tam, drawer, limits);
  } else {
   engine = new Engine2D(w, h, drawer, limits, mesh); 
  }
  engine.init(value);
}

void mouseDragged(){
  if(is3D) {
    rotX += (mouseX-pmouseX)*0.01;
    rotY -= (mouseY-pmouseY)*0.01;
  }
}

void mouseClicked() {
  if(!is3D) {
    play = false;
    px = mouseX;
    py = mouseY;
    int j = (py - (height - (h * size)) / 2) / size;
    int i = (px - (width - (w * size)) / 2) / size;
    if(0 <= i && 0 <= j && i <= w && j <= h) {
      ((Engine2D) engine).changeCell(i + 1, j + 1);
    }  
  }
}

void keyPressed() {
  if(key == 'i' || key == 'I') {
    engine.init(value);
  } else if(key == 'p' || key == 'P') {
    play = !play;
  } else if((key == 'm' || key == 'M') && !is3D) {
    mesh = !mesh;
    ((Engine2D) engine).setMesh(mesh);
  } else if(key == 'l' || key == 'L') {
    limits = !limits;
    engine.setLimits(limits);
  } else if(key == 'r' || key == 'R') {
    engine.resetBoard();
  } else if(key == 'z' || key == 'Z') {
    if(is3D) {
      is3D = false;
      engine = new Engine2D(w, h, drawer, limits, mesh);
    } else {
      is3D = true;
      engine = new Engine3D(tam, drawer, limits);
    }
    engine.init(value);
  } else if(key >= '3' && key <= '9') {
    value = int(key) - 48;
    engine.init(value);
  }
}

void keyReleased() {
  if(key == 'f' && framerate > 5) {
    framerate -= 5;
    frameRate(framerate);
  } else if(key == 'F' && framerate < 100) {
    framerate += 5;
    frameRate(framerate);
  } else if(key == 'n' || key == 'N') {
    engine.nextIteration();
  }
}

void draw() {
  background(0);
  
  pushMatrix();
    if(is3D) {
      translate(width / 2, height / 2,0);
      rotateX(rotY);
      rotateY(rotX);
      
      pushMatrix();
      translate(-((tam * size) / 2) + size / 2, -((tam * size) / 2) + size / 2, -((tam * size) / 2) + size / 2);
      engine.drawMesh(size);
      popMatrix();
      
      noFill();
      stroke(255);
      box(tam * size);
    } else {
      translate((width - (w * size)) / 2, (height - (h * size)) / 2,0);
      engine.drawMesh(size);
      
      noFill();
      stroke(255);
      rect(0,0,(w * size), (h * size));
    }
  popMatrix();
  
  if(play) {
    engine.nextIteration();
  }
}