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
lcd.clear();
}


void setup() {
lcd.init();
lcd.backlight();

Serial.begin(4800);
bienvenida();
lcd.clear();
}

void loop(){



//lcd.clear();


valor0=analogRead(pot0) / 11.36;
Serial.print(valor0);
lcd.setCursor ( 0, 0 );
lcd.print("ang:");
lcd.setCursor ( 5, 0 );
lcd.print(valor0);

valor1=analogRead(pot1) / 10.12871287;
Serial.print("-");
Serial.print(valor1);
lcd.setCursor ( 0, 1 );
lcd.print("vel:");
lcd.setCursor ( 5, 1 );
lcd.print(valor1);

int estadopuls=digitalRead(pinpuls);
Serial.print("-");
Serial.println(estadopuls);
lcd.setCursor ( 9, 0);
lcd.print("est:");
lcd.setCursor (14, 0 );
lcd.print(estadopuls);


delay(50);
lcd.clear();
}
