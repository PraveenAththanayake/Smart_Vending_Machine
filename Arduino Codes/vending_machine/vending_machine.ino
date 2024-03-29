/*--------------------VenDuino----------------
Vending machine using FULL ROTATION servos.
IOT Module Project 2024 (NSBM Students)
I/O PIN#
ServoA ~11
ServoB ~10
ButtonA 8
ButtonB 7
LEDready 13
*/

#include <Servo.h>
#include <ESP8266WiFi.h>
#include <ESP8266WebServer.h>

const int ServoA = 11;
const int ServoB = 10;
const int ButtonA = 8;
const int ButtonB = 7;
const int LEDready = 13;
long previousMillis = 0;
long intervalIdle = 500;
int LEDreadyState = LOW;

ESP8266WebServer server(80); // Create a web server on port 80

void setup() {
  pinMode(ButtonA, INPUT_PULLUP);
  pinMode(ButtonB, INPUT_PULLUP);
  pinMode(LEDready, OUTPUT);

  // Initialize WiFi
  WiFi.begin("Node MCU", "12345678");
  while (WiFi.status() != WL_CONNECTED) {
    delay(1000);
    Serial.println("Connecting to WiFi...");
  }
  Serial.println("Connected to WiFi");

  // Start the web server
  server.begin();
  Serial.println("Web server started");

  // Handle HTTP requests
  server.on("/toggle-servo-a", []() {
    servoEnable(true, false); // Toggle Servo A
    server.send(200, "text/plain", "Servo A toggled");
  });

  server.on("/toggle-servo-b", []() {
    servoEnable(false, true); // Toggle Servo B
    server.send(200, "text/plain", "Servo B toggled");
  });
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

  if (digitalRead(ButtonA) == LOW) {
    servoEnable(true, false); // Toggle Servo A
  } else if (digitalRead(ButtonB) == LOW) {
    servoEnable(false, true); // Toggle Servo B
  }

  server.handleClient();
}

void servoEnable(bool toggleServoA, bool toggleServoB) {
  if (toggleServoA) {
    // Toggle Servo A
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
  }

  if (toggleServoB) {
    // Toggle Servo B
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
  }
}