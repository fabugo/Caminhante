import java.awt.geom.Line2D;
import processing.serial.*;
Serial serial;


boolean novoQuadrado = false, novoDestino = false, novaLinha = false, novoObstaculo = false, novoComeco = true;
int px, py, sx, sy;
Grafo grafo = new Grafo();
List<Retangulo> retangulos = new ArrayList<Retangulo>();
List<PVector> caminho = new ArrayList<PVector>();

void setup() {
  size(737, 600);//width = 1.228height || px = 2.72cm
  noLoop();
  serial = new Serial(this,Serial.list()[0], 9600);
}

void draw() {
  if (novoComeco) {
    fill(#0000FF);
    rect(55, 55, 55, 55);
    novoComeco = false;
    novoDestino = true;
    grafo.addVertice(82, 82);
  }
  if (novoQuadrado) {
    if (novoDestino) {
      fill(#00FF00);
      rect(px, py, sx-px, sy-py);
      novoDestino  = false;
      grafo.addVertice((px+sx)/2, (py+sy)/2);
    } else {
      fill(#FF0000);
      rect(px, py, sx-px, sy-py);
      retangulos.add(new Retangulo(px-30, py-30, sx+30, sy+30));
    }
    novoQuadrado = false;
  }
  if (novaLinha) {
    for (Aresta a : grafo.arestas) {
      stroke(255);
      line(a.v1.x, a.v1.y, a.v2.x, a.v2.y);
    }
    for (int i = 1; i < caminho.size(); i++) {
      PVector v1 = caminho.get(i-1);
      PVector v2 = caminho.get(i);
      stroke(#00FF00);
      strokeWeight(2);
      line(v1.x, v1.y, v2.x, v2.y);
      strokeWeight(1);
      serial.write("A"+PVector.angleBetween(v1,v2));
      serial.write("D"+PVector.dist(v1,v2));
    }
    novaLinha = false;
  }
}

boolean tocaAlguem(PVector v1, PVector v2) {
  for (Aresta a : grafo.arestas) {
    if (!(a.contem(v1) || a.contem(v2))) {
      if (Line2D.linesIntersect(v1.x, v1.y, v2.x, v2.y, a.v1.x, a.v1.y, a.v2.x, a.v2.y))
        return true;
    }
  }
  return false;
}

boolean mesmoQuadrado(PVector v1, PVector v2) {
  for (Retangulo r : retangulos) {
    if (r.contem(v1) && r.contem(v2))
      return true;
  }
  return false;
}

boolean existeAresta(PVector v1, PVector v2, List<Aresta> tmpArestas) {
  for (Aresta a : tmpArestas) {
    if (a.igual(v1, v2))
      return true;
  }
  return false;
}

PVector maisProximo(PVector atual, List<Aresta> tmpArestas, PVector destino) {
  int tmpDist = 999999;
  Aresta arestaProxima = null;
  for (Aresta aresta : tmpArestas) {
    if (aresta.contem(destino))
      return destino;
    else if (aresta.distancia < tmpDist) {
      tmpDist = aresta.distancia;
      arestaProxima = aresta;
    }
  }
  if (arestaProxima == null)
    return null;
  else if (arestaProxima.v1 != atual)
    return arestaProxima.v1;
  else
    return arestaProxima.v2;
}

void removeArestas(PVector v, List<Aresta> auxArestas) {
  for (Aresta a : auxArestas) {
    if (a.contem(v))
      auxArestas.remove(a);
  }
}
List<Aresta> obterAresta(PVector v, List<Aresta> auxArestas) {
  List<Aresta> tempArestas = new ArrayList<Aresta>();
  for (Aresta a : auxArestas) {
    if (a.contem(v))
      tempArestas.add(a);
  }
  return tempArestas;
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

    PVector origem = grafo.vertices.get(0);
    PVector destino = grafo.vertices.get(1);
    PVector atual = origem;
    caminho.add(origem);

    List<Aresta> tmpArestas = new ArrayList<Aresta>();
    List<Aresta> auxArestas = new ArrayList<Aresta>(grafo.arestas);

    while (atual != destino) {
      tmpArestas = obterAresta(atual, auxArestas);
      atual = maisProximo(atual, tmpArestas, destino);
      caminho.add(atual);
      removeArestas(atual, auxArestas);
    }
    for(PVector c : caminho){
    serial.write("A"+c.angleBetween());
    
    
    }
    
    
    
    novaLinha = true;
  }
  if (key == 'n') {
    List<Aresta> tmpArestas = new ArrayList<Aresta>(); 
    for (PVector v1 : grafo.vertices) {
      for (PVector v2 : grafo.vertices) {
        if (!mesmoQuadrado(v1, v2) && !tocaAlguem(v1, v2) && v1!=v2 && !existeAresta(v1, v2, tmpArestas)) 
          tmpArestas.add(new Aresta(v1, v2));
      }
    }
    grafo.arestas.addAll(tmpArestas);
  }
  redraw();
}
