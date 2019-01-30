boolean limpar, novoQuadrado = false;
int px, py, sx, sy = 0;

ArrayList<Obstaculo> obstaculos = new ArrayList();
int matAdj[][];


void setup() {
  size(737, 600);// fator 1.228 // *2.72
  background(255);
  noLoop();
  noSmooth();
}

void draw() {
  
  //robo
  fill( 0, 0, 255);
  rect( 55, 55, 55, 55);
  
  //destino
  fill( 0, 255, 0);
  rect( 737 - 110, 600 - 110, 55, 55);
  
  if (limpar){
    background(255);
    limpar = false;
  }
  
  if (novoQuadrado){
    novoQuadrado( px, py, sx, sy);
    novoQuadrado = false;
  }
}

void mousePressed() {
  px = mouseX;
  py = mouseY;
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
  }
  if (key == ENTER){
    //criar matriz de adjacencias
    int vertices = (obstaculos.size()*4);
    matAdj = new int[vertices][vertices];
    for(int i = 0; i< vertices; i++){
      for(int j = 0; j< vertices; j++){
        matAdj[i][j] = 0;
      }
    }
    //preencher por obstaculos
    //for(int i = 0; i < obstaculos.size(); i++){
      //Obstaculo o = obstaculos.get(i);
      //line(o.p1.x,o.p1.y,o.p2.x,o.p2.y);
      stroke(0);
      line(0,0,700,600);
    //}
    //preencher entre obstaculos diferentes
    //exibir caminhos
    //exibir melhor caminho
    //enviar ao robo melhor caminho
  }
  redraw();
}

void novoQuadrado(int px, int py, int sx, int sy){
  fill(255,0,0);
  noStroke();
  rect(px, py, sx-px, sy-py);
  obstaculos.add(new Obstaculo( px, py, sx, sy));
}

//CLASSES
class Vertice{
  int x, y;
  Vertice( int x, int y){
    this.x = x;
    this.y = y;
  }
}
  
class Obstaculo{
  Vertice p1, p2, p3, p4;
  Obstaculo(int px, int py, int sx, int sy){
    p1 = new Vertice( px, py);
    p2 = new Vertice( px, sy);
    p3 = new Vertice( sx, py);
    p4 = new Vertice( sx, sy);
  }
  boolean eConcorrente(int xI1, int xF1, int yI1, int yF1, int xI2, int xF2, int yI2, int yF2){
     float bx= xF1 - xI1;
     float by= yF1 - yI1;
     float dx= xF2 - xI2;
     float dy= yF2 - yI2;
     float constPerp =bx*dy - by*dx;
     if(constPerp==0)
       return false;
      float cx= xI2 -xI1;
      float cy= yI2- yI1;
      float t = (cx*dy - cy*dx)/ constPerp;
       
      float u = (cx*by - cy*bx)/constPerp;
      if(t<0 ||t>1)
          return false;
        else if(u<0 || u<1)
          return false;
          else 
            return true;
          
   }
}
