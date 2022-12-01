import processing.serial.*;

Serial serial;


void setup() {
  size(400, 400);
  serial = new Serial(this, "COM14", 9600);
}

void draw() {
  if (mousePressed) {
    if(mouseX<width/2){
    serial.write(1);
    }else {
    serial.write(9);
  }
  delay(100);
}
}
