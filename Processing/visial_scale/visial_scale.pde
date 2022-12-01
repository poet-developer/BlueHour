import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

import processing.sound.*;
import processing.video.*;
import processing.serial.*;
Serial myPort;
Serial BT;
Movie night1;
Movie night2;
Movie night3;
Movie blueHour;
Movie morning1;
Minim minim = new Minim(this);
AudioPlayer night;
AudioPlayer TV;
AudioPlayer beep;
AudioPlayer reboot;
AudioPlayer morning;
AudioPlayer errorsound;
AudioPlayer errorsound2;


int sensor1, sensor2, sensor3, sensor4;
boolean NStep1 =false;
boolean NStep2 = false;
int check1 =0; //Night
int check2=0; //Morning
int B1, B2, B3 =0;
int A1, A2, A3 =0;
int down = 0;
int time; 
int bt =0;
int savedTime1=0; 
int ledVersion = 0;
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
  fullScreen(SPAN);
  //  size(3465,778);
  background(0);
  time = millis();
  savedTime1 = millis();
  frameRate(120);
  myPort = new Serial(this, "COM10", 9600) ;
  BT = new Serial(this, "COM14", 9600);
  img1 = loadImage("1dmd.png");
  error =loadImage("Error.png");
  blueScreen = loadImage("BLUESCREEN.png");
  //error = loadImage("error.png");
  night1 = new Movie(this, "night1.mp4");
  night2 = new Movie(this, "night2.mp4");
  night3 = new Movie(this, "night3.mp4");
  morning1 = new Movie(this, "morning1.mp4");
  blueHour = new Movie(this, "BlueHour.mp4");
  image(img1, 160, 0, 730, 778); //1
  image(img1, 1220, 0, 965, 778); //2
  image(img1, 2560, 0, 950, 778); //3
  night = minim.loadFile("dj krush - song 2.mp3");
  TV = minim.loadFile("television.mp3");
  TV.setGain(-5);
  beep = minim.loadFile("beep.wav");
  beep.setGain(-20);
  reboot = minim.loadFile("reboot.mp3");
  morning = minim.loadFile( "morning.mp3");
  errorsound =minim.loadFile("Windows - error.mp3");
  errorsound2 =minim.loadFile("Windows - Error2.mp3");

  myPort.write(7);
}

void draw() {
  if (myPort.available() > 3) {
    sensor1 = myPort.read();
    sensor2 = myPort.read();
    sensor3 = myPort.read();
    sensor4 = myPort.read();
  }

  if (ledVersion ==1) {
    BT.write(1);
  } else if (ledVersion ==2) {
    BT.write(2);
  } else if (ledVersion ==3) {
    BT.write(3);
  } else if (ledVersion ==4) {
    BT.write(4);
  } else if (ledVersion ==0) {
    BT.write(9);
  } //????

  if (change ==1) {
    if (bgm == 1) {
      night.play();
    }
    NIGHT();
  }

  if (change == 2) {

    if (threeS == false && B3 == 3) {
      if (down ==0) {
        if (millis()>time+5000) {
          time = millis();
          down ++;
        }
        imageMode(CENTER);
        errorsound.play(1000);
        image(error, width/6, height/2, 400, 200);
        image(error, width/2, height/2, 400, 200);
        image(error, width/6*5, height/2, 400, 200);
        imageMode(CORNER);
      }

      if (down == 1) {
        if (millis()>time+5000) {
          time = millis();
          down ++;
          bgm =2;
        }
      }

      if (down ==2) {
        //   println("5 seconds have passed!");
        imageMode(CENTER);
        image(error, random(0, width), random(0, height), 400, 200);
        imageMode(CORNER);
        ledVersion =1;
        if (millis()>time+3000) {
          time = millis();
          down ++;
        }

        if (bgm ==2) {
          errorsound2.play(7500);
          bgm =3;
        }
      }

      if (down ==3) {
        // ledVersion =5;
        if (bgm ==3) {
          errorsound2.close();
          TV.play();
          beep.play();
          background(0);
          bgm =4;
        }
        image(blueScreen, 0, 0, 1024, 778);
        image(blueScreen, 1220, 0, 1024, 778);
        image(blueScreen, 2560, 0, 1024, 778);
        blueSign();
      }
    }
  }

  if (threeS == true) {
    down =0;
    if (bgm ==4) {
      reboot.play();
      TV.close();
      beep.close();
      background(0);
      bgm =5;
    }

    blueHour.play();
    image(blueHour, 160, 0, 730, 778);
    image(blueHour, 1220, 0, 965, 778);
    image(blueHour, 2560, 0, 950, 778);
    ledVersion =2;

    if (blueHour.time()>8) {
      change =4;
      threeS = false;
    }
  }



  if (change == 4) {
    ledVersion =3;
    if (bgm ==5) {
      reboot.close();
      morning.play();
      bgm = 6;
    }
    //image(---,0,0,width/3,height);
    //image(---,width/3,0,width/3,height);
    //image(---,width/3*2,0,width/3,height);
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
    check1 =1;
  } else if (sensor2 == 1) {
    check1 =2;
  } else if (sensor3 == 1) {
    check1 =3;
  }

  if (check1 ==1) {
    night1.loop();
    image(night1, 160, 0, 730, 778);
    image(img1, 2560, 0, 950, 778);
    image(img1, 1220, 0, 965, 778);
    // println("1");
    NStep1 =true;
  } 

  if (check1 ==2 && NStep1 ==true) {
    night2.loop();
    image(night2, 2560, 0, 950, 778);
    image(img1, 160, 0, 730, 778);
    image(img1, 1220, 0, 965, 778);
    //println("2");
    NStep2 = true;
  }

  if (check1 == 3 && NStep2 ==true) {
    night3.loop();
    image(img1, 160, 0, 730, 778);
    image(img1, 2560, 0, 950, 778);
    image(night3, 1220, 0, 965, 778);
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
    //   println("Check1");
  }
  if (check1 == 2 && B1 == 1) {
    //B1 =1;
    B2 =2;
    B3 =0;
    // println("Check2");
  }
  if (check1 == 3 && B2 ==2) {
    //B1 =1;
    //B2 = 2;
    if (Time1 >8) {
      B3 =3;
      change =2;
      night.close();
      night1.stop();
      night2.stop();
      night3.stop();
      bgm =2;
      // println("Check3");
      //println("night3 +" + Time3);
    }
  }
}

void blueSign() {
  if (sensor4 == 1) {
    threeS = true;
  } else if (sensor4 == 9) {
    threeS = false;
  }
}

void MORNING() {
  CheckSensing2();

  if (sensor3 == 1) {
    morning1.loop();
    image(img1, 160, 0, 730, 778);
    image(img1, 2560, 0, 950, 778);
    image(morning1, 1220, 0, 965, 778);
    // println("2-3");
    check2 =1;
  }
  if (sensor2 == 1) {
    morning1.loop();
    image(morning1, 2560, 0, 950, 778);
    image(img1, 160, 0, 730, 778);
    image(img1, 1220, 0, 965, 778);
    //println("2-2");
    check2 =2;
  }

  if (sensor1 == 1) {
    morning1.loop();
    image(morning1, 160, 0, 730, 778);
    image(img1, 2560, 0, 950, 778);
    image(img1, 1220, 0, 965, 778);
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
      down =0;
      ledVersion =5;
      bgm =1;
    }
    println("Check3-2");
  }
}



void movieEvent (Movie m) {
  m.read();
}
