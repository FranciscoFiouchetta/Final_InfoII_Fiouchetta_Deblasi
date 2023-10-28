import processing.serial.*;
Serial Puerto;

int boton_mouse=0;

float velocidad;
float radianes;
float angulo;
float velocidad_estatica;
float angulo_estatico;

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
  size(1300, 500);
  println(Serial.list()); 
  Puerto = new Serial(this, "COM4",4800);
  Puerto.bufferUntil('\n');
}

void draw() {
  
  background(0,160,0);
  translate(0,500);
  noStroke();
  textSize(40);
  
  fill(255,255,255);
  rect(350,-140,400,40);
  fill(0,0,0);
  text("INFO",510,-107);
  
  fill(255,255,255);
  rect(350,-200,400,40);
  fill(0,0,0);
  text("PUNTUACIONES",415,-167);
  
  fill(255,255,255);
  rect(350,-260,400,40);
  fill(0,0,0);
  text("JUGAR",490,-227);
  
  fill(255,255,255);
  rect(240,-400,620,60);
  fill(0,0,0);
  text("DEBLACHETTA PARABOLIC CANNON",250,-357);
  
  if(mousePressed == true){
    boton_mouse = 1;
  }
  if(mouseX < 750 && mouseX > 350 && mouseY < 280 && mouseY > 240 && mousePressed == true){
    boton_mouse = 1;
  }
  if(boton_mouse == 1){
     JUEGO();
  }
  if(mouseX < 750 && mouseX > 350 && mouseY < 340 && mouseY > 300 && mousePressed == true){
  }
  if(mouseX < 750 && mouseX > 350 && mouseY < 400 && mouseY > 360 && mousePressed == true){
  }

}
void JUEGO(){
  
  translate(0,-500);
  
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

    //print(angulo); // Muestra el valor convertido en la consola
    //print(" ",velocidad); 
    //println(" ",estado_boton);

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
  
  if((posicion_x > 400 && posicion_x < 420) && (posicion_y > 200 && posicion_y < 220)){
      puntuacion_rojo = 1;
      posicion_x = 0;
      posicion_y = 0;
      disparando = 0;
      tiempo = 0;
  }
  
  if((posicion_x > 400 && posicion_x < 420) && ((posicion_y > 220 && posicion_y < 240) || (posicion_y < 200 && posicion_y > 180))){
      puntuacion_amarillo = 1;
      posicion_x = 0;
      posicion_y = 0;
      disparando = 0;
      tiempo = 0;
  }
  
  if((posicion_x > 400 && posicion_x < 420) && ((posicion_y > 240 && posicion_y < 270) || (posicion_y < 180 && posicion_y > 150))){
      puntuacion_blanco = 1;
      posicion_x = 0;
      posicion_y = 0;
      disparando = 0;
      tiempo = 0;
  }
  
  print(puntuacion_blanco);
  print(puntuacion_amarillo);
  println(puntuacion_rojo);
  
  int ValorRojo = int(map(velocidad, 0, 100, 0, 255));
  int ValorAzul = int(map(velocidad, 0, 100, 255, 0));
  color ColorBarra =  color(ValorRojo,0,ValorAzul);
 
  
  fill(128, 64, 0);
  stroke(0,0,0);
  strokeWeight(1);
  rect(-21,-31,101,11);
  
  fill(ColorBarra);
  noStroke();
  rect(-20,-31,velocidad,10);
  
  fill(255, 255, 255);
  rect(-20,400,30,30);
  
  if(mouseX < 50 && mouseX > 20 && mouseY < 50 && mouseY > 20 && mousePressed == true){
    boton_mouse = 0;
  }
  
  rotate(radianes); // Cañón
  stroke(0, 255, 0);
  strokeWeight(10);
  line(20, 0, 35, 0);

}
void PUNTUACIONES(){};
void INFO(){}

