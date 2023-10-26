import processing.serial.*;
Serial Puerto;

float velocidad;
float angulo;
float radianes;
int estado;
float posicion_x=0;
float posicion_y=0;
float tiempo=0;
int disparo;
int x;

void setup() {
  size(1200, 500);
  println(Serial.list());
  Puerto = new Serial(this, "COM4", 4800);
  Puerto.bufferUntil('\n');
 
}

void draw() {
 
  String inString = Puerto.readStringUntil('\n'); // Lee la cadena hasta encontrar un salto de línea

  if (inString != null) {
    inString = trim(inString); // Elimina los espacios en blanco
    String[] parts = inString.split("-");
    String part1 = parts[0];
    String part2 = parts[1];
    String part3 = parts[2];
    angulo = float(part1);
    velocidad = float(part2);
    estado = int(part3);
    print(angulo); // Muestra el valor convertido en la consola
    print(" ",velocidad); // Muestra el valor convertido en la consola
    println(" ",estado); // Muestra el valor convertido en la consola
  }
 
  background(0, 170, 228);
  //angulo=45;
  radianes = -angulo * PI/180;
 
  translate(40, height - 50);
  fill(0, 0, 0);
  noStroke();
 
  fill(128, 64, 0);
  noStroke();
  rect(-40, 0, 1300, 50);

  fill(0, 255, 0);
  noStroke();
  arc(0, 0, 40, 40, PI, TWO_PI);
 
 
  if(estado==1){
      disparo = 1;
  }
  if(disparo==1){
    posicion_x = velocidad*cos(radianes)*tiempo;
    posicion_y = velocidad*sin(radianes)*tiempo+(0.5)*(9.8)*(tiempo * tiempo);
    fill(255, 255, 255);
    ellipse(posicion_x,posicion_y,10,10);
    tiempo = tiempo + 0.1;
   
   if (posicion_y>0){
      disparo = 0;
      tiempo = 0;
   }
}

  rect(x,-100,50,20);
  x = x + 5;
 
  if(x>1200){
  x = -40;
  }

  rotate(radianes);
  fill(10, 100, 10);
  stroke(0, 0, 0);
  strokeWeight(10);
  line(20, 0, 35, 0);
   
}
