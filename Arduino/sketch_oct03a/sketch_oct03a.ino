int trig1 = 2;
int echo1 = 3;
int trig2 = 4;
int echo2 = 5;
int trig3 = 6;
int echo3 = 7;


long duration1, duration2, duration3;
long distance1, distance2, distance3;

void setup() {
Serial.begin(9600);

  pinMode(trig1, OUTPUT);
  pinMode(echo1, INPUT);
    pinMode(trig2, OUTPUT);
  pinMode(echo2, INPUT);
  pinMode(trig3, OUTPUT);
  pinMode(echo3, INPUT);

}

void loop() {
   digitalWrite(trig1, LOW);
    delayMicroseconds(2);
    digitalWrite(trig1, HIGH);
    delayMicroseconds(10);
    digitalWrite(trig1, LOW);
    duration1 = pulseIn(echo1, HIGH);
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
  // put your main code here, to run repeatedly:
 distance1 = (duration1 * 340) / 2 / 10000;
  distance2 = (duration2 * 340) / 2 / 10000;
    distance3 = (duration3 * 340) / 2 / 10000;
 delay(500);
  if (distance1 < 100) {
      Serial.println(1);
    } else {
      Serial.println(2);
    }

      if (distance2 < 100) {
      Serial.println(3);
    } else {
      Serial.println(4);
    }

    if (distance3 < 100) {
      Serial.println(5);;
    } else {
      Serial.println(6);
    }
}
