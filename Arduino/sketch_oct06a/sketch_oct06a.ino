void setup() {
  pinMode(A5, INPUT);
  Serial.begin(9600);

}

void loop() {
  // put your main code here, to run repeatedly:
  if (analogRead(A5)) {
   // int sensing = map(analogRead(A0), 0, 1023, 0, 100);
    Serial.println(analogRead(A5));
  }
}
