int pinpuls=2;
int pot0=A0;
int pot1=A1;
int valor0=0;
int valor1=0;

void setup() {

//pinMode(pinpuls,INPUT);
Serial.begin(4800);

}

void loop() {


valor0=analogRead(pot0) / 11.36;
Serial.print(valor0);

valor1=analogRead(pot1) / 10.23;
Serial.print("-");
Serial.print(valor1);

int estadopuls=digitalRead(pinpuls);
Serial.print("-");
Serial.println(estadopuls);


delay(100);
}
