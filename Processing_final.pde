import processing.sound.*;

import ddf.minim.*;
import processing.serial.*;

Minim cadena;
AudioPlayer cancion;
Serial Puerto;

float velocidad;
float angulo;
float velocidad_estatica;
float angulo_estatico;
float radianes;
float posicion_x=0;
float posicion_y=0;
float tiempo=0;
int estado_boton;
int disparando;
int objetivo_x;
int objetivo_y;
int puntuacion_rojo=0;
int puntuacion_amarillo=0;
int puntuacion_blanco=0;

void setup() {
  size(1100, 500);
  println(Serial.list()); 
  Puerto = new Serial(this, "COM5", 4800);
  Puerto.bufferUntil('\n');
  cadena=new Minim(this);
  cancion=cadena.loadFile("Get Ready for This.mp3");
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
  radianes = angulo * PI/180;
  
  scale(1,-1); // Invertir el eje y
  translate(40, -height + 50); // Mover el origen hacia abajo a la izquierda
 
  fill(128, 64, 0); // Crear el rectangulo de la tierra
  noStroke();
  rect(-40, 0, 1100, -50);

  fill(0, 255, 0); // Base del cañón 
  noStroke();
  arc(0, 0, 40, 40, 0, PI);
 
  if(estado_boton==1 && posicion_y <= 0){ // Cambiar el estado de 'disparando' a 1 cuando se pulse el botón
      disparando = 1;
      velocidad_estatica = velocidad;
      angulo_estatico = radianes;
  }

  if(disparando == 1){ // Mover la pelota cuando 'disparando' sea igual a 1
    posicion_x = velocidad_estatica*cos(angulo_estatico)*tiempo;
    posicion_y = velocidad_estatica*sin(angulo_estatico)*tiempo-(0.5)*(9.8)*(tiempo * tiempo);
    fill(255, 255, 255);
    ellipse(posicion_x,posicion_y,10,10);
    tiempo = tiempo + 0.1;
}

  if(posicion_y < 0){ // Reiniciar la variable 'tiempo' y la variable 'disparando' cuando la pelota toque la tierra
      disparando = 0;
      tiempo = 0;
  }
  
  fill(255, 0, 0); // Objetivo a golpear
  rect(400,200,20,20);
  
  fill(255, 255, 0);
  rect(400,220,20,20);
 
  fill(255, 255, 0);
  rect(400,180,20,20);
  
  fill(255, 255, 255);
  rect(400,240,20,30);
 
  fill(255, 255, 255);
  rect(400,150,20,30);
  
  /*
  if((posicion_x > 400 && posicion_x < 402) && (posicion_y > 200 && posicion_y < 220)){
      puntuacion_rojo = 1;
  }
  if((posicion_x > 400 && posicion_x < 402) && ((posicion_y > 220 && posicion_y < 240) || (posicion_y < 200 && posicion_y > 180))){
      puntuacion_amarillo = 1;
  }
  if((posicion_x > 400 && posicion_x < 402)  && ((posicion_y > 240 && posicion_y < 270) || (posicion_y < 180 && posicion_y > 150))){
      puntuacion_blanco = 1;
  }
  if(posicion_y<0){
    puntuacion_rojo = 0;
    puntuacion_amarillo = 0;
    puntuacion_blanco = 0;
  }

  stroke(0, 0, 0);
  strokeWeight(1);
  line(-40,200,1100,200);
  
  stroke(0, 0, 0);
  strokeWeight(1);
  line(400,500,400,0);
  
  print("puntuacion_rojo: ",puntuacion_rojo);
  print(" puntuacion_amarillo: ",puntuacion_amarillo);
  println(" puntuacion_blanco: ",puntuacion_blanco);
  
  */
  
  int ValorRojo = int(map(velocidad, 0, 100, 0, 255));
  //int ValorVerde = int(map(velocidad,0, 100,255,0));
  int ValorAzul = int(map(velocidad, 0, 100, 255, 0));
  color ColorBarra =  color(ValorRojo,0,ValorAzul);
 
  
  fill(128, 64, 0);
  stroke(0,0,0);
  strokeWeight(1);
  rect(-21,-31,101,11);
  
  fill(ColorBarra);
  noStroke();
  rect(-20,-31,velocidad,10);
  
  
  rotate(radianes); // Cañón
  stroke(0, 255, 0);
  strokeWeight(10);
  line(20, 0, 35, 0);
  
}
