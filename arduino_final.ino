int pin_pulsador=2;
int pot0=A0;
int pot1=A1;
int valor0=0;
int valor1=0;

void setup() {
pinMode(pin_pulsador,INPUT);
Serial.begin(4800);
}

void loop() {

valor0 = analogRead(pot0) / 11.36; // Se divide la entrada del primer potenciometro (ángulo) para pasar del rango '0-1023' al rango '0-90'y se almacena ese dato en valor0
Serial.print(valor0);

valor1 = analogRead(pot1) / 10.23; // Se divide la entrada del segundo potenciometro (velocidad inicial) para pasar del rango '0-1023' al rango '0-100' y se almacena ese dato en valor1
Serial.print("-");
Serial.print(valor1);

int estado_pulsador = digitalRead(pin_pulsador); // Se lee la entrada 2 y se guarda su estado en estado_pulsador
Serial.print("-");
Serial.println(estado_pulsador);

delay(100);
}
