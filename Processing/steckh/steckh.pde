import processing.video.*;

Movie night1;
Movie night2;

void setup(){
  size(1366,2300);
  frameRate(30);
background(175);
night1 = new Movie(this, "night1.mp4");
night2 = new Movie(this, "night2.mp4");
fill(0);
rect(0,0,width,768);

fill(0,255,0);
rect(171,768,1024,768);
}

void draw(){
  night1.loop();
  night2.loop();
  image(night1, 171, 0, 1024, 768); // 1/2monitors
  image(night2, 300, 768, 1024-250,768);// 4monitor USA AGV
  
}

void movieEvent (Movie m) {
  m.read();
}

widthX1, 0, scaleX1, scaleY
widthX1, heightY, scaleX1, scaleY
widthX2, heightY*2, scaleX2, scaleY
