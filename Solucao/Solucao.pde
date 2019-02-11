import pathfinder.*; //<>//
import java.awt.geom.Line2D;
import processing.serial.*;
import pt.citar.diablu.nxt.brick.*;
import pt.citar.diablu.nxt.protocol.*;
import pt.citar.diablu.processing.nxt.*;
Serial serial;
boolean novoQuadrado = false, novoDestino = false, novaLinha = false, novoObstaculo = false, novoComeco = true;
int px, py, sx, sy;
Graph grafo = new Graph();
ArrayList<Obstaculo> obstaculos = new ArrayList<Obstaculo>();
GraphSearch_Dijkstra search = new GraphSearch_Dijkstra(grafo);
GraphNode[] rota;
LegoNXT lego;
void setup() {
  size(737, 600);//width = 1.228height || px = 2.72cm
  noLoop();
  //lego = new LegoNXT(this, Serial.list()[1]);
  //serial = new Serial(this, Serial.list()[1], 9600);
}
void draw() {
  if (novoComeco) {
    int id = grafo.getNbrNodes();
    GraphNode origem = new GraphNode(id, 82, 82);
    grafo.addNode(origem);
    fill(#0000FF);
    rectMode(CENTER);
    rect(origem.xf(), origem.yf(), 55, 55);
    novoComeco = false;
    novoDestino = true;
  }
  if (novoQuadrado) {
    if (novoDestino) {
      int id = grafo.getNbrNodes();
      GraphNode destino = new GraphNode(id, (px+sx)/2, (py+sy)/2);
      grafo.addNode(destino);
      fill(#00FF00);
      rect(destino.xf(), destino.yf(), 55, 55);
      novoDestino  = false;
    } else 
    criarObstaculo(px, py, sx, sy);
    novoQuadrado = false;
  }
  if (novaLinha) {
    for (GraphEdge e : grafo.getAllEdgeArray()) {
      stroke(#0000FF);
      strokeWeight(2);
      line(e.from().xf(), e.from().yf(), e.to().xf(), e.to().yf());
    }
    for (int i = 1; i < rota.length; i++) {
      stroke(#00FF00);
      strokeWeight(2);
      line(rota[i-1].xf(), rota[i-1].yf(), rota[i].xf(), rota[i].yf());
    }
  }
}
void mousePressed() {
  px = mouseX;
  py = mouseY;
}
void mouseReleased() {
  sx = mouseX;
  sy = mouseY;
  novoQuadrado = true;
  redraw();
}
void keyPressed() {
  if (key == ENTER) {
    novaLinha = true;
    for (GraphNode n1 : grafo.getNodeArray()) {
      for (GraphNode n2 : grafo.getNodeArray()) {
        if (n1.id() != n2.id() && !tocaAlguem(n1, n2) && !mesmoQuadrado(n1, n2))
          grafo.addEdge(n1.id(), n2.id(), dist(n1.xf(), n1.yf(), n2.xf(), n2.yf()));
      }
    }
    search.search(0, 1, true);
    rota = search.getRoute();
  }
  if (key == 'c') {
    
  }
  redraw();
}
boolean mesmoQuadrado(GraphNode n1, GraphNode n2) {
  for (Obstaculo o : obstaculos) {
    if (o.contem(n1) && o.contem(n2))
      return true;
  }
  return false;
}
boolean tocaAlguem(GraphNode n1, GraphNode n2) {
  for (GraphEdge e : grafo.getAllEdgeArray()) {
    if (!(edgeContem(e, n1) || edgeContem(e, n2))) 
      if (Line2D.linesIntersect(n1.xf(), n1.yf(), n2.xf(), n2.yf(), e.from().xf(), e.from().yf(), e.to().xf(), e.to().yf()))
        return true;
  }
  return false;
}
boolean edgeContem(GraphEdge e, GraphNode n) {
  return (e.from().id() == n.id() || e.to().id() == n.id());
}
void criarObstaculo(int px, int py, int sx, int sy) {
  int id = grafo.getNbrNodes();
  GraphNode n1 = new GraphNode(id, px, py);
  id++;
  GraphNode n2 = new GraphNode(id, px, sy);
  id++;
  GraphNode n3 = new GraphNode(id, sx, py);
  id++;
  GraphNode n4 = new GraphNode(id, sx, sy);
  id++;
  obstaculos.add(new Obstaculo(n1, n2, n3, n4));
  grafo.addNode(n1);
  grafo.addNode(n2);
  grafo.addNode(n3);
  grafo.addNode(n4);
  grafo.addEdge(n1.id(), n2.id(), dist(n1.xf(), n1.yf(), n2.xf(), n2.yf()));
  grafo.addEdge(n1.id(), n3.id(), dist(n1.xf(), n1.yf(), n3.xf(), n3.yf()));
  grafo.addEdge(n2.id(), n4.id(), dist(n2.xf(), n2.yf(), n4.xf(), n4.yf()));
  grafo.addEdge(n3.id(), n4.id(), dist(n3.xf(), n3.yf(), n4.xf(), n4.yf()));
  fill(#FF0000);
  rectMode(CORNER);
  rect(n1.xf(), n1.yf(), n4.xf()-n1.xf(), n4.yf()-n1.yf());
}
class Obstaculo {
  GraphNode n1, n2, n3, n4;
  Obstaculo(GraphNode n1, GraphNode n2, GraphNode n3, GraphNode n4) {
    this.n1 = n1;  
    this.n2 = n2; 
    this.n3 = n3; 
    this.n4 = n4;
  }
  boolean contem(GraphNode n) {
    return (n.id() == n1.id() || n.id() == n2.id() || n.id() == n3.id() || n.id() == n4.id());
  }
}
