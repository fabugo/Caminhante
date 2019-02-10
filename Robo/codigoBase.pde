import processing.serial.*;
Serial serial;

char angulo;
char dist;
void setup() {
  
  angulo = (char)90;
  
  println(Serial.list());
  serial = new Serial(this,Serial.list()[0], 9600);
   println("Connected");

  
  angulo = (char)90;
   println("mandei o angulo");
    println("A"+angulo);
  serial.write("A"+angulo);
  println("angulo entregue");
  
  
  dist = (char) 10;
  serial.write("D"+dist);
  println("mandei a distancia");
  
  
  

}
