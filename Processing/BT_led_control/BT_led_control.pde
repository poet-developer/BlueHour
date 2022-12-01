import processing.serial.*;

Serial BT;

void setup() {
  size(400, 400);
  BT = new Serial(this, "COM5", 9600);
 // BT.write(0);
}

void draw() {
  if (mouseX<width/2 && mouseY<height/2) {
    BT.write(1);
  } else if (mouseX>width/2 && mouseY<height/2) {
    BT.write(2);
  } else if (mouseX<width/2 && mouseY>height/2) {
    BT.write(3);
  } else if(mouseX>width/2 && mouseY>height/2){
    BT.write(4);
  }
}
