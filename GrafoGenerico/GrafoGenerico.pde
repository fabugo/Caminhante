class Vertice{
  int ID;
  ArrayList<adjacencia> adjacencias;
   int getID(){
    return this.ID;
  }
  void setID(int ID){
    this.ID =ID;
  }
  int addAdjacencia(float distancia, Vertice destino){
     adjacencia nova = new adjacencia(destino, distancia);
     this.adjacencias.add(nova); 
     return destino.getID();
  }
  int rmAdjacencia(int IDrm){
  adjacencia iterador;
  for(int i=0; i<adjacencias.size() ; i++){
     iterador=adjacencias.get(i);
     if(iterador.destino.getID()==IDrm){
       adjacencias.remove(i);
       }
     }
  }
  boolean eVizinho(int IDvz){
    adjacencia iterador;
    for(int i=0; i<adjacencias.size() ; i++){
        iterador=adjacencias.get(1);
        if(iterador.destino.getID()==IDvz){
          return true;
        }
      }
      return false;
  }
   class adjacencia{
    Vertice destino;
    float distancia;
    adjacencia(Vertice v, float distancia){
    this.destino= v;
    this.distancia=distancia;
    }
  }
}
class Grafo{
  ArrayList<Vertice> vertices;
  
  
  
}
