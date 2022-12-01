int val;

void setup() {
pinMode(2,INPUT);
pinMode(13,OUTPUT);
Serial.begin(9600);
  // put your setup code here, to run once:

}

void loop() {
  if(digitalRead(2) == LOW){
    digitalWrite(13,LOW);
    Serial.println(0);
  }else{
    Serial.println(1);
    digitalWrite(13,HIGH);
  }
  delay(1000);
  // put your main code here, to run repeatedly:

}
