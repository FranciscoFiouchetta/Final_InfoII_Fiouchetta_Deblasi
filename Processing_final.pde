import processing.serial.*;
Serial Puerto;

float velocidad;
float angulo;
float radianes;
float posicion_x=0;
float posicion_y=0;
float tiempo=0;
int estado_boton;
int disparando;
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

    String[] parts = inString.split("-"); // Divide la cadena en tres cadenas distintas
    String part1 = parts[0];
    String part2 = parts[1];
    String part3 = parts[2];

    angulo = float(part1); // Se coloca el contenido de esas cadenas en sus variables correspondientes
    velocidad = float(part2);
    estado_boton = int(part3);

    print(angulo); // Muestra el valor convertido en la consola
    print(" ",velocidad); 
    println(" ",estado_boton);

  }
 
  background(0, 170, 228);
  radianes = -angulo * PI/180;
 
  translate(40, height - 50); // Mover el origen hacia abajo a la izquierda
 
  fill(128, 64, 0); // Crear el rectangulo de la tierra
  noStroke();
  rect(-40, 0, 1300, 50);

  fill(0, 255, 0); // Base del cañón 
  noStroke();
  arc(0, 0, 40, 40, PI, TWO_PI);
 
  if(estado_boton==1){ // Cambiar el estado de 'disparando' a 1 cuando se pulse el botón
      disparando = 1;
  }

  if(disparando == 1){ // Mover la pelota cuando 'disparando' sea igual a 1

    posicion_x = velocidad*cos(radianes)*tiempo;
    posicion_y = velocidad*sin(radianes)*tiempo+(0.5)*(9.8)*(tiempo * tiempo);
    fill(255, 255, 255);
    ellipse(posicion_x,posicion_y,10,10);
    tiempo = tiempo + 0.1;

  }

  if(posicion_y > 0){ // Reiniciar la variable 'tiempo' y la variable 'disparando' cuando la pelota toque la tierra
      disparando = 0;
      tiempo = 0;
  }

  rect(x,-100,50,20); // Objetivo a golpear
  x = x + 5;
 
  if(x>1200){
  x = -40;
  }

  rotate(radianes); // Cañón
  fill(10, 100, 10);
  stroke(0, 0, 0);
  strokeWeight(10);
  line(20, 0, 35, 0);
   
}
