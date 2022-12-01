import processing.sound.*;
import processing.video.*;
import processing.serial.*;
Serial myPort;
Movie night1;
Movie night2;
Movie night3;
Movie blueHour;
Movie morning1;
SoundFile night;
SoundFile TV;
SoundFile beep;
SoundFile reboot;
SoundFile morning;

int sensor1, sensor2, sensor3, sensor4;
int check1 =0; //Night
int check2=0; //Morning
int B1, B2, B3 =0;
int A1, A2, A3 =0;
int down = 0;
int savedTime; 
PImage img1;
PImage blueScreen;
PImage error;
//PImage error;
int change =1;
boolean threeS = false;

float Time3 = 0;
float Time1 =0;

int bgm =1 ;

void setup() {
  size(2000, 700);
  savedTime = millis();
  myPort = new Serial(this, "COM7", 9600) ;
  img1 = loadImage("1dmd.png");
  error =loadImage("Error.png");
  blueScreen = loadImage("BLUESCREEN.png");
  //error = loadImage("error.png");
  night1 = new Movie(this, "night1.mp4");
  night2 = new Movie(this, "night2.mp4");
  night3 = new Movie(this, "night3.mp4");
  morning1 = new Movie(this, "morning1.mp4");
  blueHour = new Movie(this, "BlueHour.mp4");
  image(img1, 0, 0, width/3, height);
  image(img1, width/3, 0, width/3, height);
  image(img1, width/3*2, 0, width/3, height);
  night = new SoundFile(this, "dj krush - song 2.mp3");
  TV = new SoundFile(this, "television.mp3");
  beep = new SoundFile(this, "beep.wav");
  reboot = new SoundFile(this, "reboot.mp3");
  morning = new SoundFile(this, "morning.mp3");

  myPort.write(7);
}

void draw() {
  if (myPort.available() > 2) {
    sensor1 = myPort.read();
    sensor2 = myPort.read();
    sensor3 = myPort.read();
    //sensor4 = myPort.read();
  }

  if (change ==1) {
    if (bgm == 1) {
      morning.stop();
      night.play();
      bgm =2;
    }
    NIGHT();
  }

  if (change == 2) {

    if (threeS == false && B3 == 3) {
      if (down == 0) {
        imageMode(CENTER);
        image(error, width/6, height/2, 200, 100);
        image(error, width/2, height/2, 200, 100);
        image(error, width/6*5, height/2, 200, 100);
        down = 1;
      }
      if (down == 1) {
        int passedTime = millis() - savedTime;
        if (passedTime>5000) {
          println("5 seconds have passed!");
          fill(100);
          image(error, random(0, width), random(0, height), 200, 100);
          if (passedTime >10000) {
            down =2;
          }
        }
      }
      if(down ==2){
      if (bgm ==2) {
        TV.play();
        beep.play();
        bgm =3;
      }
      image(blueScreen, 0, 0, width/3, height);
      image(blueScreen, width/3, 0, width/3, height);
      image(blueScreen, width/3*2, 0, width/3, height);
      blueSign();
    }
    }

    if (threeS == true) {
      if (bgm ==3) {
        reboot.play();
        TV.stop();
        beep.stop();
        bgm =4;
      }
      blueHour.play();
      image(blueHour, 0, 0, width/3, height);
      image(blueHour, width/3, 0, width/3, height);
      image(blueHour, width/3*2, 0, width/3, height);


      if (blueHour.time()>5) {
        change =4;
        threeS = false;
        bgm =4;
      }
    }
  }  


  if (change == 4 && threeS == false) {
    if (bgm ==4) {
      reboot.stop();
      morning.play();
      bgm =1;
    }
    MORNING();
  }


  println(sensor1);
  println(sensor2);
  println(sensor3);
  println(sensor4);
  println("------------");

  myPort.write(7);
}

void NIGHT() {
  CheckSensing1();

  if (sensor1 == 1) { 
    night1.loop();
    image(night1, 0, 0, width/3, height);
    image(img1, width/3, 0, width/3, height);
    image(img1, width/3*2, 0, width/3, height);
    // println("1");
    check1 =1;
  }

  if (sensor2 == 1) {
    night2.loop();
    image(night2, width/3, 0, width/3, height);
    image(img1, 0, 0, width/3, height);
    image(img1, width/3*2, 0, width/3, height);
    //println("2");
    check1 =2;
  }

  if (sensor3 == 1) {
    night3.loop();
    image(night3, width/3*2, 0, width/3, height);
    image(img1, width/3, 0, width/3, height);
    image(img1, 0, 0, width/3, height);
    //println("3");
    check1 =3;
    Time1 = night3.time();
  }
}


void CheckSensing1() {
  if (check1 == 1 && B1 == 0) {
    B1 =1;
    B2 =0;
    B3 =0;
    println("Check1");
  }
  if (check1 == 2 && B1 == 1) {
    //B1 =1;
    B2 =2;
    B3 =0;
    println("Check2");
  }
  if (check1 == 3 && B2 ==2) {
    //B1 =1;
    //B2 = 2;
    if (Time1 >5) {
      B3 =3;
      change =2;
      night.stop();
      bgm =2;
      println("Check3");
      println("night3 +" + Time3);
    }
  }
}

void blueSign() {
  if (sensor4 == 1) {
    threeS = true;
    bgm =3;
  }
}

void MORNING() {
  CheckSensing2();

  if (sensor3 == 1) {
    morning1.loop();
    image(morning1, width/3*2, 0, width/3, height);
    // println("2-3");
    check2 =1;
  }

  if (sensor2 == 1) {
    morning1.loop();
    image(morning1, width/3, 0, width/3, height);
    image(img1, width/3*2, 0, width/3, height);
    //println("2-2");
    check2 =2;
  }

  if (sensor1 == 1) {
    morning1.loop();
    image(morning1, 0, 0, width/3, height);
    image(img1, width/3, 0, width/3, height);
    //println("2-1");
    check2 =3;
    Time3 = morning1.time();
  }
}
void CheckSensing2() {

  if (check2 == 1 && A1 == 0) {
    A1 =1;
    A2 =0;
    A3 =0;
    println("Check1-2");
  }
  if (check2 == 2 && A1 == 1) {
    //B1 =1;
    A2 =2;
    A3 =0;
    println("Check2-2");
  }
  if (check2 == 3 && A2 ==2) {
    //B1 =1;
    //B2 = 2;
    A3 =3;
    if (Time3 > 15) {
      B1=0;
      B2=0;
      B3=0;
      A1=0;
      A2=0;
      A3=0;
      check1 =0;
      check2 =0;
      change =1;
    }
    println("Check3-2");
  }
}



void movieEvent (Movie m) {
  m.read();
}
