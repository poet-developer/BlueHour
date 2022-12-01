int trig2 = 4;
int echo2 = 5;
int trig3 = 6;
int echo3 = 7;
int var1;
int d;
int change = 1;
int var2;

long duration1, duration2, duration3;
long distance1, distance2, distance3;

byte sensor1, sensor2, sensor3, sensor4;

void setup() {
  Serial.begin(9600);

  pinMode(2, INPUT);
  pinMode(trig2, OUTPUT);
  pinMode(echo2, INPUT);
  pinMode(trig3, OUTPUT);
  pinMode(echo3, INPUT);
  pinMode(A5, INPUT);
}

void loop() {
  if (Serial.available() > 0) {
    Serial.read();

    digitalWrite(trig2, LOW);
    delayMicroseconds(2);
    digitalWrite(trig2, HIGH);
    delayMicroseconds(10);
    digitalWrite(trig2, LOW);
    duration2 = pulseIn(echo2, HIGH);

    digitalWrite(trig3, LOW);
    delayMicroseconds(2);
    digitalWrite(trig3, HIGH);
    delayMicroseconds(10);
    digitalWrite(trig3, LOW);
    duration3 = pulseIn(echo3, HIGH);

    distance2 = (duration2 * 340) / 2 / 10000;
    distance3 = (duration3 * 340) / 2 / 10000;
    if (digitalRead(2) == HIGH) {
      sensor1 = 1;
    } else {
      sensor1 = 9;
    }
    if (distance2 < 20) {
      sensor2 = 1;
    } else {
      sensor2 = 9;
    }

    if (distance3 < 20) {
      sensor3 = 1;
    } else {
      sensor3 = 9;
    }

    if (analogRead(A5) > 100) {
      sensor4 = 1;
    } else {
      sensor4 = 9;
    }

    Serial.write(sensor1);
    Serial.write(sensor2);
    Serial.write(sensor3);
    Serial.write(sensor4);
  }
}
