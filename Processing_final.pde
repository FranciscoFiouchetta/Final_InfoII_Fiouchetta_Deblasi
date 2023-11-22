import processing.serial.*;
Serial Puerto;

import processing.video.*;

Movie video1;
Movie video2;

int vector[] = new int[10];
Puntuacion miPuntuacion;

int boton_mouse=0;

float velocidad;
float radianes;
float angulo;
float velocidad_estatica;
float angulo_estatico;

float posicion_x = 0;
float posicion_y = 0;
float tiempo=0;

int estado_boton;
int disparando;
int objetivo_x;
int objetivo_y;

int movimiento = 0;
int cambiar_sentido = 1; // 1 ó (-1)
int contacto = 0;
int vidas = 5;
int punt;

float timer;
boolean videoVisible = true;
boolean videoFinalizado = false;

int vector[] = new int[10];
int i;
int puntuacion;
int aux;

void setup() {
  size(1100, 500);
  video1 = new Movie(this, "C:/Users/admin/OneDrive/Escritorio/proyecto final/messi.mp4"); // Utilizar "/" en lugar de "\"
  video2 = new Movie(this, "C:/Users/admin/OneDrive/Escritorio/proyecto final/momo.mp4");
 miPuntuacion = new Puntuacion(Puerto);
  println(Serial.list());
  Puerto = new Serial(this, "COM6",4800);
  Puerto.bufferUntil('\n');
}

void draw() {
  
  background(40,40,160);
  translate(0,500);
  noStroke();
  textSize(40);

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
  
  if(mouseX < 750 && mouseX > 350 && mouseY < 280 && mouseY > 240 && mousePressed == true){
    boton_mouse = 1;
  }
  if(boton_mouse == 1){
     JUEGO();
  }
  if(mouseX < 750 && mouseX > 350 && mouseY < 340 && mouseY > 300 && mousePressed == true){
    boton_mouse = 2;
  }
  if(boton_mouse == 2){
    PUNTUACIONES();
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
    String part4 = parts[3];


    angulo = float(part1); // Se coloca el contenido de esas cadenas en sus variables correspondientes
    velocidad = float(part2);
    estado_boton = int(part3);
    punt = int(part4);

    miPuntuacion.actualizarPuntuacion(vidas, contacto, punt);
    vector = miPuntuacion.obtenerVector();

    print(angulo); // Muestra el valor convertido en la consola
    print(" ",velocidad); 
    print(" ",estado_boton);
    print(" ",vidas);
    
    println(" ", punt);
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
      vidas = vidas - 1;
      posicion_y = 0;
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
  
  if(mouseX < 50 && mouseX > 20 && mousePressed == true){
    boton_mouse = 0;
  }
  
  rotate(radianes); // Cañón
  stroke(0, 255, 0);
  strokeWeight(10);
  line(20, 0, 35, 0);
  
    if(vidas == 0 || contacto == 5){ // Algoritmo de guardado de puntuaciones
    
      for(i=0;i<9;i++){
        aux = vector[i+1];
        vector[i+1] = vector[i];
        vector[i] = aux;
      }
      vector[i] = puntuacion;
      Puerto.write("H"); // Envia una señal para reiniciar la variable puntuacion
    }
  
  if(contacto == 5){ //VIDEO
   
  rotate(-radianes);
  scale(1,-1);
  frameRate(25);
  
    if (videoVisible == true) {
      video1.play();
      video1.read();
      image(video1, 310, -425, 400, 400);
    }
    if (video1.time() > 3.8) {
      video1.stop();
      videoVisible = false; // Oculta el video al finalizar la reproducción.
      videoFinalizado = true;
      clear();
    }
    if(videoFinalizado == true){
      noStroke();
      fill(255,255,255);
      rect(320,-233,400,40);
      fill(0,0,0);
      text("Volver a intentar",380,-200);
      
      if(mouseX < 760 && mouseX > 350 && mouseY < 257 && mouseY > 217 && mousePressed == true){
          contacto = 0;
          vidas = 5;
          videoVisible = true;
          videoFinalizado = false;
        }
    }  
  }
  
    if (vidas == 0) {
      
    rotate(-radianes);
    scale(1,-1);
    frameRate(30);
  
      if(videoVisible == true) {
        video2.play();
        video2.read();
        image(video2, 310, -425, 400, 400);
      }
      
      if(video2.time() > 3.8) {
        video2.stop();
        videoVisible = false; // Oculta el video al finalizar la reproducción.
        videoFinalizado = true;
        clear();
      }
      if(videoFinalizado == true){
        noStroke();
        fill(255,255,255);
        rect(320,-233,400,40);
        fill(0,0,0);
        text("Volver a intentar",380,-200);
        
        if(mouseX < 760 && mouseX > 350 && mouseY < 257 && mouseY > 217 && mousePressed == true){
          contacto = 0;
          vidas = 5;
          videoVisible = true;
          videoFinalizado = false;
        }
      }
   }
    
   frameRate(60);
}

void nivel_1(){
  
  if (vidas != 0){
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
  }

  
  if((posicion_x > 400 && posicion_x < 420) && 
  (posicion_y > 200 && posicion_y < 220)){

      Puerto.write("R");
      
      posicion_x = 0;
      posicion_y = 0;
      
      disparando = 0;
      tiempo = 0;
      
      contacto = 1;
  }
  
  if((posicion_x > 400 && posicion_x < 420) && 
  ((posicion_y > 220 && posicion_y < 240) || 
  (posicion_y < 200 && posicion_y > 180))){

      Puerto.write("A");
      posicion_x = 0;
      posicion_y = 0;
      
      disparando = 0;
      tiempo = 0;
      
      contacto = 1;
  }
  
  if((posicion_x > 400 && posicion_x < 420) && 
  ((posicion_y > 240 && posicion_y < 270) || 
  (posicion_y < 180 && posicion_y > 150))){

      Puerto.write("B");
      posicion_x = 0;
      posicion_y = 0;
      
      disparando = 0;
      tiempo = 0;
      
      contacto = 1;
  }
  
}
void nivel_2(){
  
  if (vidas != 0){
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
  }
  
  if((posicion_x > 880 && posicion_x < 900) && 
  (posicion_y > 200 && posicion_y < 220)){
    
       Puerto.write("R");
     
      posicion_x = 0;
      posicion_y = 0;
      
      disparando = 0;
      tiempo = 0;
      
      contacto = 2;
  }
  
  if((posicion_x > 880 && posicion_x < 900) && 
  ((posicion_y > 220 && posicion_y < 240) || 
  (posicion_y < 200 && posicion_y > 180))){

      Puerto.write("A");
      
      posicion_x = 0;
      posicion_y = 0;
      
      disparando = 0;
      tiempo = 0;
      
      contacto = 2;
  }
  
  if((posicion_x > 880 && posicion_x < 900) && 
  ((posicion_y > 240 && posicion_y < 270) || 
  (posicion_y < 180 && posicion_y > 150))){
      
      Puerto.write("B");
      
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
  
  if (vidas != 0){
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
  }
  
  if((posicion_x > 880 && posicion_x < 900) && 
  (posicion_y > 200 + movimiento && posicion_y < 220 + movimiento)){

      Puerto.write("R");
      
      posicion_x = 0;
      posicion_y = 0;
      
      disparando = 0;
      tiempo = 0;
      
      contacto = 3;
  }
  
  if((posicion_x > 880 && posicion_x < 900) && 
  ((posicion_y > 220 + movimiento && posicion_y < 240 + movimiento) || 
  (posicion_y < 200 + movimiento && posicion_y > 180 + movimiento))){
    
      Puerto.write("A");
      
      posicion_x = 0;
      posicion_y = 0;
      
      disparando = 0;
      tiempo = 0;
      
      contacto = 3;
  }
  
  if((posicion_x > 880 && posicion_x < 900) && 
  ((posicion_y > 240 + movimiento && posicion_y < 270 + movimiento) || 
  (posicion_y < 180 + movimiento && posicion_y > 150 + movimiento))){
    
      Puerto.write("B");
      
      posicion_x = 0;
      posicion_y = 0;
      
      disparando = 0;
      tiempo = 0;
      
      contacto = 3;
  }
  
}
void nivel_4(){
  
  if (vidas != 0){
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

  }
  
  if((posicion_x > 500 && posicion_x < 520) && 
  (posicion_y > 20 && posicion_y < 40)){
  
      Puerto.write("R");
      
      posicion_x = 0;
      posicion_y = 0;
      
      disparando = 0;
      tiempo = 0;
      
      contacto = 4;
  }
  
  if((posicion_y > 20 && posicion_y < 40) && 
  ((posicion_x > 520 && posicion_x < 540) || 
  (posicion_x < 500 && posicion_x > 480))){
    
      Puerto.write("A");
      
      posicion_x = 0;
      posicion_y = 0;
      
      disparando = 0;
      tiempo = 0;
      
      contacto = 4;
  }
  
  if((posicion_y > 20 && posicion_y < 40) && 
  ((posicion_x > 540 && posicion_x < 570) || 
  (posicion_x < 460 && posicion_x > 430))){
    
      Puerto.write("B");
      
      posicion_x = 0;
      posicion_y = 0;
      
      disparando = 0;
      tiempo = 0;
      
      contacto = 4;
  }
  
  if(posicion_x > 230 && posicion_x < 260 && posicion_y > 0 && posicion_y < 300){
    disparando = 0;
    tiempo = 0;
    vidas = vidas - 1;
    posicion_y = 0;
  }
  
}
void nivel_5(){
  
  movimiento += 2 * cambiar_sentido;
  
  if(movimiento == 180 || movimiento == -150){
    cambiar_sentido = cambiar_sentido * (-1);
  }
  
  if (vidas != 0){
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
  }
  
  if((posicion_x > 500 + movimiento && posicion_x < 520 + movimiento) && 
  (posicion_y > 20 && posicion_y < 40)){
    
      Puerto.write("R");
      
      posicion_x = 0;
      posicion_y = 0;
      
      disparando = 0;
      tiempo = 0;
      
      contacto = 5;
  }
  
  if((posicion_y > 20 && posicion_y < 40) && 
  ((posicion_x > 520 + movimiento && posicion_x < 540 + movimiento) || 
  (posicion_x < 500 + movimiento && posicion_x > 480 + movimiento))){

      Puerto.write("A");
      
      posicion_x = 0;
      posicion_y = 0;
      
      disparando = 0;
      tiempo = 0;
      
      contacto = 5;
  }
  
  if((posicion_y > 20 && posicion_y < 40) && 
  ((posicion_x > 540 + movimiento && posicion_x < 570 + movimiento) || 
  (posicion_x < 460 + movimiento && posicion_x > 430 + movimiento))){

      Puerto.write("B");
      
      posicion_x = 0;
      posicion_y = 0;
      
      disparando = 0;
      tiempo = 0;
      
      contacto = 5;
  }
  
  if(posicion_x > 230 && posicion_x < 260 && posicion_y > 0 && posicion_y < 300){
    disparando = 0;
    tiempo = 0;
    vidas = vidas - 1;
    posicion_y = 0;
  }
  
}
void PUNTUACIONES(){

  background(0,0,0);
  noStroke();
  fill(255);
  rect(50,-50,1000,-400);
  fill(5);
  text("PUNTAJES",460,-400);
  
   int[] vector = miPuntuacion.obtenerVector();
  
  
  text("PUNT 1: ",175,-350);
  text(vector[0], 320,-350);
  
  text("PUNT 2: ",175,-300);
  text(vector[1], 320,-300);
  
  text("PUNT 3: ",175,-250);
  text(vector[2], 320,-250);
  
  text("PUNT 4: ",175,-200);
  text(vector[3], 320,-200);
  
  text("PUNT 5: ",175,-150);
  text(vector[4], 320,-150);
  
  
  text("PUNT 1: ",750,-350);
  text(vector[5], 895,-350);
  
  text("PUNT 2: ",750,-300);
  text(vector[6], 895,-300);
  
  text("PUNT 3: ",750,-250);
  text(vector[7], 895,-250);
  
  text("PUNT 4: ",750,-200);
  text(vector[8], 895,-200);
  
  text("PUNT 5: ",750,-150);
  text(vector[9], 895,-150);
  
  fill(255, 255, 255);
  rect(10,-490,30,30);
  
  if(mouseX < 50 && mouseX > 20 && mousePressed == true){
    boton_mouse = 0;
  }
};
class Puntuacion{
  
  
  int puntuacion;
  
  Serial Puerto;
  
   Puntuacion(Serial puerto) {
    this.Puerto = puerto;
    
  }
    
  void actualizarPuntuacion(int vidas, int contacto, int punt) {
    
    if (vidas == 0 || contacto == 5) { // Algoritmo de guardado de puntuaciones
      for (int i = 8; i > 0; i--) {
        vector[i + 1] = vector[i];
      }
      puntuacion = punt;
      vector[0] = puntuacion;
      //Puerto.write("H"); // Envia una señal para reiniciar la variable puntuacion
      
    }
  }
