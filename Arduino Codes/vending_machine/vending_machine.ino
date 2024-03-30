/*--------------------VenDuino---------------
Vending machine using FULL ROTATION servos.
IOT Module Project 2024 (NSBM Students)

I/O           PIN#
ServoA        ~11
ServoB        ~10
ButtonA         8
ButtonB         7
LEDready       13
*/

#include <Servo.h>
#include <ESP8266WiFi.h>


const int ServoA = 11;
const int ServoB = 10;

const int ButtonA = 8;
const int ButtonB = 7;

const int LEDready = 13;

long previousMillis = 0;
long intervalIdle = 500;
int LEDreadyState = LOW;

void setup() {
  pinMode(ButtonA, INPUT_PULLUP);
  pinMode(ButtonB, INPUT_PULLUP);
  pinMode(LEDready, OUTPUT);
}

void loop() {
  unsigned long currentMillis = millis();
  
  if (currentMillis - previousMillis >= intervalIdle) { 
    previousMillis = currentMillis;

    if (LEDreadyState == LOW) {  
      LEDreadyState = HIGH;
    } else {
      LEDreadyState = LOW;
    }
    digitalWrite(LEDready, LEDreadyState);
  }

  if (digitalRead(ButtonA) == LOW || digitalRead(ButtonB) == LOW) {
    servoEnable();
  }
}

void servoEnable() {
  while (digitalRead(ButtonA) == LOW || digitalRead(ButtonB) == LOW) {
    if (digitalRead(ButtonA) == LOW) {
      for (int i = 0; i < 2; i++) {
        digitalWrite(LEDready, HIGH);
        delay(50);
        digitalWrite(LEDready, LOW);
        delay(50);
      }

      for (int i = 0; i < 57; i++) {
        digitalWrite(ServoA, HIGH);
        delayMicroseconds(1700);
        digitalWrite(ServoA, LOW);
        delay(18.5); 
      }
      break;
    }

    if (digitalRead(ButtonB) == LOW) {
      for (int i = 0; i < 2; i++) {
        digitalWrite(LEDready, HIGH);
        delay(50);
        digitalWrite(LEDready, LOW);
        delay(50);
      }

      for (int i = 0; i < 57; i++) {
        digitalWrite(ServoB, HIGH);
        delayMicroseconds(1700);
        digitalWrite(ServoB, LOW);
        delay(18.5); 
      }
      break;
    }
  }
}
