int time;
int retime;
int inter;
int change =0;

void setup(){
  size(400,400);
  time = millis();
  inter =5000;
  
}

void draw(){
  if(change ==0){
  if(millis()> time + inter){
    time = millis();
    change =1;
  }
  }
  if(change ==1){
  fill(random(0,255));
  rect(200,200,100,100);
  change =0;
  }
}
  //if(mousePressed){
  //  int check = inter*2
  
