import processing.video.*;

Movie night1;

void setup(){
  size(1366,2300);
background(175);
night1 = new Movie(this, "night1.mp4");
}


fill(255,0,0);
rect(0,0,width,768);

fill(0,255,0);
rect(171,768,1024,768);
