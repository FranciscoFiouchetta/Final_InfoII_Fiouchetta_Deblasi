#include <LiquidCrystal_I2C.h>

#include <Wire.h> 
LiquidCrystal_I2C lcd(0x27,16,2);


int pinpuls=2;
int pot0=A0;
int pot1=A1;
int valor0=0;
int valor1=0;
String mensaje1="BIENVENIDOS....";
String mensaje2="DEBLACHETTA PARABOLIC CANNON";
int longtexto1=mensaje1.length();
int longtexto2=mensaje2.length();
int posicion;
int puntuacion;

void bienvenida() {

lcd.setCursor(7,0);
lcd.print(mensaje1);
lcd.setCursor(0,1);
lcd.print(mensaje2);
delay(500);

for(posicion=0;posicion<longtexto1;posicion++){
lcd.scrollDisplayLeft();
delay(200);
}
for(posicion=0;posicion<longtexto2;posicion++){
lcd.scrollDisplayLeft();
delay(200);
}
//lcd.clear();
}


void setup() {
lcd.init();
lcd.backlight();
Serial.begin(4800);
bienvenida();
lcd.clear();
lcd.setCursor(0,0);
lcd.print("ANG:");
lcd.setCursor(0,1);
lcd.print("VEL:");
}

void loop(){

//lcd.clear();
if (Serial.available() > 0) {
     char letra = Serial.read();
    if (letra == 'R') {
    int puntuacion_rojo = Serial.parseInt();
            puntuacion+=100;
            letra == 'F';     
        }// Mostrar la puntuación recibida desde Processing
   
    else if (letra == 'A') {
    int puntuacion_amarillo = Serial.parseInt();
            puntuacion+=50;
            letra == 'F';    
        }
     else if (letra == 'B') {
        int puntuacion_blanco = Serial.parseInt();
           puntuacion+=25;
           letra == 'F';    
        }
           lcd.setCursor(13, 1);
           lcd.print(puntuacion);
           delay(1000);
  }


int valorpotenciometro0=analogRead(pot0) / 11.36;
if (valorpotenciometro0 != valor0){
lcd.setCursor ( 5, 0 );
lcd.print("   ");
lcd.setCursor ( 5, 0 );
lcd.print(valorpotenciometro0);
delay(10);
valor0=valorpotenciometro0;
}
int valorpotenciometro1=analogRead(pot1) / 8.525;
if (valorpotenciometro1!=valor1){
lcd.setCursor ( 5, 1 );
lcd.print("   ");
lcd.setCursor ( 5, 1 );
lcd.print(valorpotenciometro1);
delay(10);
valor1=valorpotenciometro1;
}
int estadopuls=digitalRead(pinpuls);
lcd.setCursor ( 9, 0);
lcd.print("EST:");
lcd.setCursor (14, 0 );
lcd.print(estadopuls);

lcd.setCursor(9, 1);
lcd.print("PNT: ");

Serial.print(valor0);
Serial.print("-");
Serial.print(valor1);
Serial.print("-");
Serial.println(estadopuls);
 

delay(10);

}
