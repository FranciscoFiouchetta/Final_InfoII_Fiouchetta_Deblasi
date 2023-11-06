import processing.serial.*;
Serial Puerto;

import processing.video.*;

Movie video;

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

int movimiento = 0;
int cambiar_sentido = 1; // 1 ó (-1)
int contacto = 0;
int puntuacion = 0;
int puntuacion_rojo=0;
int puntuacion_amarillo=0;
int puntuacion_blanco=0;

boolean videoVisible = true;

void setup() {
  size(1100, 500);
  frameRate(30);
  video = new Movie(this, "C:/Users/User/Desktop/momo.mp4"); // Utiliza "/" en lugar de "\"
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
  
  // NIVELES
  if(contacto==0){
  nivel_1();
  }
  if(contacto==1){
  nivel_2();
  }
  if(contacto==2){
  nivel_3();
  }
  if(contacto==3){
  nivel_4();
  }
  if(contacto==4){
  nivel_5();
  }
  
  if(contacto==5){ //VIDEO
    scale(1,-1);
    if (videoVisible == true) {
      video.play();
      video.read();
      image(video, 400, 200, 200, 200);
    }
    if (video.time() == 4) {
      video.stop();
      videoVisible = false; // Oculta el video al finalizar la reproducción.
      clear();
    }
  }
  
  int ValorRojo = int(map(velocidad, 0, 100, 0, 255));
  int ValorAzul = int(map(velocidad, 0, 100, 255, 0));
  color ColorBarra =  color(ValorRojo,0,ValorAzul);
 
  
  fill(128, 64, 0);
  stroke(0,0,0);
  strokeWeight(1);
  rect(-21,-31,121,11);
  
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
void nivel_1(){
  
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
  

  
  if((posicion_x > 400 && posicion_x < 420) && 
  (posicion_y > 200 && posicion_y < 220)){
    
      puntuacion_rojo = 1;
      posicion_x = 0;
      posicion_y = 0;
      
      disparando = 0;
      tiempo = 0;
      
      contacto = 1;
  }
  
  if((posicion_x > 400 && posicion_x < 420) && 
  ((posicion_y > 220 && posicion_y < 240) || 
  (posicion_y < 200 && posicion_y > 180))){
    
      puntuacion_amarillo = 1;
      posicion_x = 0;
      posicion_y = 0;
      
      disparando = 0;
      tiempo = 0;
      
      contacto = 1;
  }
  
  if((posicion_x > 400 && posicion_x < 420) && 
  ((posicion_y > 240 && posicion_y < 270) || 
  (posicion_y < 180 && posicion_y > 150))){
    
      puntuacion_blanco = 1;
      posicion_x = 0;
      posicion_y = 0;
      
      disparando = 0;
      tiempo = 0;
      
      contacto = 1;
  }
  
}
void nivel_2(){
  
  fill(255, 0, 0); // Objetivo a golpear
  rect(880,200,20,20);
  
  fill(255, 255, 0);
  rect(880,220,20,20);
 
  fill(255, 255, 0);
  rect(880,180,20,20);
  
  fill(255, 255, 255);
  rect(880,240,20,30);
 
  fill(255, 255, 255);
  rect(880,150,20,30);
  
  if((posicion_x > 880 && posicion_x < 900) && 
  (posicion_y > 200 && posicion_y < 220)){
    
      puntuacion_rojo = 1;
      posicion_x = 0;
      posicion_y = 0;
      
      disparando = 0;
      tiempo = 0;
      
      contacto = 2;
  }
  
  if((posicion_x > 880 && posicion_x < 900) && 
  ((posicion_y > 220 && posicion_y < 240) || 
  (posicion_y < 200 && posicion_y > 180))){
    
      puntuacion_amarillo = 1;
      posicion_x = 0;
      posicion_y = 0;
      
      disparando = 0;
      tiempo = 0;
      
      contacto = 2;
  }
  
  if((posicion_x > 880 && posicion_x < 900) && 
  ((posicion_y > 240 && posicion_y < 270) || 
  (posicion_y < 180 && posicion_y > 150))){
    
      puntuacion_blanco = 1;
      posicion_x = 0;
      posicion_y = 0;
      
      disparando = 0;
      tiempo = 0;
      
      contacto = 2;
  }
  
}
void nivel_3(){
  
  movimiento += 2 * cambiar_sentido;
  
  if(movimiento == 180 || movimiento == -150){
    cambiar_sentido = cambiar_sentido * (-1);
  }
  
  fill(255, 0, 0); // Objetivo a golpear
  rect(880,200 + movimiento,20,20);
  
  fill(255, 255, 0);
  rect(880,220 + movimiento,20,20);
 
  fill(255, 255, 0);
  rect(880,180 + movimiento,20,20);
  
  fill(255, 255, 255);
  rect(880,240 + movimiento,20,30);
 
  fill(255, 255, 255);
  rect(880,150 + movimiento,20,30);
  
  if((posicion_x > 880 && posicion_x < 900) && 
  (posicion_y > 200 + movimiento && posicion_y < 220 + movimiento)){
    
      puntuacion_rojo = 1;
      posicion_x = 0;
      posicion_y = 0;
      
      disparando = 0;
      tiempo = 0;
      
      contacto = 3;
  }
  
  if((posicion_x > 880 && posicion_x < 900) && 
  ((posicion_y > 220 + movimiento && posicion_y < 240 + movimiento) || 
  (posicion_y < 200 + movimiento && posicion_y > 180 + movimiento))){
    
      puntuacion_amarillo = 1;
      posicion_x = 0;
      posicion_y = 0;
      
      disparando = 0;
      tiempo = 0;
      
      contacto = 3;
  }
  
  if((posicion_x > 880 && posicion_x < 900) && 
  ((posicion_y > 240 + movimiento && posicion_y < 270 + movimiento) || 
  (posicion_y < 180 + movimiento && posicion_y > 150 + movimiento))){
    
      puntuacion_blanco = 1;
      posicion_x = 0;
      posicion_y = 0;
      
      disparando = 0;
      tiempo = 0;
      
      contacto = 3;
  }
  
}
void nivel_4(){
  
  fill(255, 0, 0); // Objetivo a golpear
  rect(500,20,20,20);
  
  fill(255, 255, 0);
  rect(520,20,20,20);
 
  fill(255, 255, 0);
  rect(480,20,20,20);
  
  fill(255, 255, 255);
  rect(540,20,30,20);
 
  fill(255, 255, 255);
  rect(450,20,30,20);
  
  //PARED
  fill(0, 0, 0);
  rect(230,0,40,300);
  
  if((posicion_x > 500 && posicion_x < 520) && 
  (posicion_y > 20 && posicion_y < 40)){
    
      puntuacion_rojo = 1;
      posicion_x = 0;
      posicion_y = 0;
      
      disparando = 0;
      tiempo = 0;
      
      contacto = 4;
  }
  
  if((posicion_y > 20 && posicion_y < 40) && 
  ((posicion_x > 520 && posicion_x < 540) || 
  (posicion_x < 500 && posicion_x > 480))){
    
      puntuacion_amarillo = 1;
      posicion_x = 0;
      posicion_y = 0;
      
      disparando = 0;
      tiempo = 0;
      
      contacto = 4;
  }
  
  if((posicion_y > 20 && posicion_y < 40) && 
  ((posicion_x > 540 && posicion_x < 570) || 
  (posicion_x < 460 && posicion_x > 430))){
    
      puntuacion_blanco = 1;
      posicion_x = 0;
      posicion_y = 0;
      
      disparando = 0;
      tiempo = 0;
      
      contacto = 4;
  }
  
  
}
void nivel_5(){
  
  movimiento += 2 * cambiar_sentido;
  
  if(movimiento == 180 || movimiento == -150){
    cambiar_sentido = cambiar_sentido * (-1);
  }
  
  fill(255, 0, 0); // Objetivo a golpear
  rect(500 + movimiento,20,20,20);
  
  fill(255, 255, 0);
  rect(520 + movimiento,20,20,20);
 
  fill(255, 255, 0);
  rect(480 + movimiento,20,20,20);
  
  fill(255, 255, 255);
  rect(540 + movimiento,20,30,20);
 
  fill(255, 255, 255);
  rect(450 + movimiento,20,30,20);
  
  //PARED
  fill(0, 0, 0);
  rect(230,0,40,300);
  
  if((posicion_x > 500 + movimiento && posicion_x < 520 + movimiento) && 
  (posicion_y > 20 && posicion_y < 40)){
    
      puntuacion_rojo = 1;
      posicion_x = 0;
      posicion_y = 0;
      
      disparando = 0;
      tiempo = 0;
      
      contacto = 5;
  }
  
  if((posicion_y > 20 && posicion_y < 40) && 
  ((posicion_x > 520 + movimiento && posicion_x < 540 + movimiento) || 
  (posicion_x < 500 + movimiento && posicion_x > 480 + movimiento))){
    
      puntuacion_amarillo = 1;
      posicion_x = 0;
      posicion_y = 0;
      
      disparando = 0;
      tiempo = 0;
      
      contacto = 5;
  }
  
  if((posicion_y > 20 && posicion_y < 40) && 
  ((posicion_x > 540 + movimiento && posicion_x < 570 + movimiento) || 
  (posicion_x < 460 + movimiento && posicion_x > 430 + movimiento))){
    
      puntuacion_blanco = 1;
      posicion_x = 0;
      posicion_y = 0;
      
      disparando = 0;
      tiempo = 0;
      
      contacto = 5;
  }
  
}
void PUNTUACIONES(){};
void INFO(){}
