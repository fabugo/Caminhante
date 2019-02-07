import java.awt.geom.Line2D;


boolean novoQuadrado = false, novoDestino = false, novaLinha = false, novoObstaculo = false, novoComeco = true;
int px, py, sx, sy;
Grafo grafo = new Grafo();
List<Retangulo> retangulos = new ArrayList<Retangulo>();

void setup() {
  size(737, 600);// fatores 1.228 // *2.72
  noLoop();
}

void draw() {
   if(novoComeco){
     fill(#0000FF);
     rect(55, 55, 55, 55);
     novoComeco = false;
     novoDestino = true;
     grafo.addVertice(82,82);
   }
  if (novoQuadrado){
    if(novoDestino){
      fill(#00FF00);
      rect(px, py, sx-px, sy-py);
      novoDestino  = false;
      grafo.addVertice((px+sx)/2,(py+sy)/2);
    }else{
      fill(#FF0000);
      rect(px, py, sx-px, sy-py);
      retangulos.add(new Retangulo(px-55, py-55, sx+55, sy+55));
      fill(#000000);
      textSize(8);
      String string = px + ","+ py;
      text(string , px, py);
      string = px + ","+ sy;
      text(string , px, sy);
      string = sx + ","+ py;
      text(string , sx, py);
      string = sx + ","+ sy;
      text(string , sx, sy);
   
    }
    novoQuadrado = false;
  }
  if(novaLinha){
    for(Aresta a : grafo.arestas){
      stroke(255);
      line(a.v1.x, a.v1.y, a.v2.x, a.v2.y);
    }
    novaLinha = false;
  }
}

boolean tocaAlguem(PVector v1, PVector v2){
  for(Aresta a : grafo.arestas){
    if(!(a.contem(v1) || a.contem(v2))){
      println("aresta: ", a.v1,a.v2);
      if(Line2D.linesIntersect(v1.x,v1.y,v2.x,v2.y,a.v1.x,a.v1.y,a.v2.x,a.v2.y)) //<>//
        return true;
    }
  }
  return false;
}

boolean mesmoQuadrado(PVector v1, PVector v2){
  boolean mq = false;
  for(Retangulo r : retangulos){
    mq = r.contem(v1) && r.contem(v2);
    if(mq)
      break;
  }
  return mq;
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
  if (key == ENTER){
    novaLinha = true;
  }
  if (key == 'n'){
    List<Aresta> tmpArestas = new ArrayList<Aresta>();
    for(Retangulo r : retangulos){
      for(PVector v1 : r.vertices){
        for(PVector v2 : grafo.vertices){
          println("\n",v1,v2,":");
          if(mesmoQuadrado(v1,v2)){
            println("mesmo quadrado");
          }else{
            if (!tocaAlguem(v1,v2)){
              println("criar aresta",v1,v2);
              tmpArestas.add(new Aresta(v1,v2));
            }else{
              println(v1,v2, "tocou");
            }
          }
        }
      }
    }
      grafo.arestas.addAll(tmpArestas); 
    }
  redraw();
}
