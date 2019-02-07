class Aresta {
  PVector v1;
  PVector v2;
  int distancia;
  Aresta(PVector v1, PVector v2) {
      this.v1 = v1;
      this.v2 = v2;
      this.distancia = (int) dist(v1.x,v1.y,v2.x,v2.y);
  }
  boolean contem(PVector v){
    return (v == v1 || v == v2);
  }
}
