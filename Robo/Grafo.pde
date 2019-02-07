import java.util.List;
import java.util.ArrayList;

class Grafo {
  List<PVector> vertices;
  List<Aresta> arestas;
  Grafo() {
    vertices = new ArrayList<PVector>();
    arestas = new ArrayList<Aresta>();
  }
  PVector addVertice(int x, int y) {
    PVector v = new PVector(x,y);
    vertices.add(v);
    return v;
  }
  Aresta addAresta(PVector v1, PVector v2) {
    Aresta a = new Aresta(v1, v2);
    arestas.add(a);
    return a;
  }
}
