int savedTime; 
int version =0;
PImage error;

void setup() {
  size(900, 300);
  savedTime = millis();
  background(255);
  error = loadImage("Error.png");
}

void draw() {
  if (version ==0) {
    if (mousePressed) {

      imageMode(CENTER);
      image(error,width/6, height/2, 200, 100);
      image(error,width/2, height/2, 200, 100);
      image(error,width/6*5, height/2, 200, 100);
      version =1;
    }
  }


  if (version ==1) {
    int passedTime = millis() - savedTime;

    if (passedTime>5000) {
      println("5 seconds have passed!");
        fill(100);
        image(error,random(0, width), random(0, height), 200, 100);
        if (passedTime >10000) {
          version =2;
        }
      }
      //delay(400);
    }
  
  if(version ==2){
    background(255);
    version =0;
  }
}
