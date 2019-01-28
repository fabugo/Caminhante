boolean limpar = false;
boolean novoQuadrado = false;

int px,py,sx,sy = 0;

void setup() {
  size(737, 600);
  stroke(255);
  noLoop();
}

void draw() {
  if (limpar){
    background(255);
    limpar = false;
  }
  else if (novoQuadrado){
    novoQuadrado(px,py,sx,sy);
    novoQuadrado = false;
  } 
}
void mousePressed() {
  px = mouseX;
  py = mouseY;
  redraw();
}
void mouseReleased(){
  sx = mouseX;
  sy = mouseY;
  novoQuadrado = true;
  redraw();
}
void keyPressed(){
  if (key == DELETE) {
    limpar = true;
    redraw();
  }
  if (key == ENTER){
    
  }
}

void novoQuadrado(int px, int py, int sx, int sy){
  fill(0);
  rect(px, py, sx-px, sy-py);
  println(px, py, sx-px, sy-py);
}
