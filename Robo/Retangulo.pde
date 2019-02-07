class Retangulo{
  List<PVector> vertices;
  Retangulo(int px, int py, int sx, int sy){
    vertices = new ArrayList<PVector>();
    vertices.add(grafo.addVertice(px, py));
    vertices.add(grafo.addVertice(px, sy));
    vertices.add(grafo.addVertice(sx, py));
    vertices.add(grafo.addVertice(sx, sy));
    grafo.addAresta(vertices.get(0), vertices.get(1));
    grafo.addAresta(vertices.get(0), vertices.get(2));
    grafo.addAresta(vertices.get(1), vertices.get(3));
    grafo.addAresta(vertices.get(2), vertices.get(3));
  }
  boolean contem(PVector vertice){
    for(PVector v : vertices){
      if(vertice == v)
        return true;
     }
   return false;
  }
}
