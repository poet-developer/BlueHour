#include <SoftwareSerial.h>
#include <Adafruit_NeoPixel.h>
#define PIN1 A0
#define PIN2 A2
#define PIN3 A1
//data out이 연결된 핀 번호
#define NUM_LEDS 60

SoftwareSerial serial(2, 3);
//Serial serial;
Adafruit_NeoPixel strip1 = Adafruit_NeoPixel(NUM_LEDS, PIN1, NEO_GRBW + NEO_KHZ800);
Adafruit_NeoPixel strip2 = Adafruit_NeoPixel(NUM_LEDS, PIN2, NEO_GRBW + NEO_KHZ800);
Adafruit_NeoPixel strip3 = Adafruit_NeoPixel(NUM_LEDS, PIN3, NEO_GRB + NEO_KHZ800);

int Rb1, Rb2, Rb3 = 0;
int Bb1, Bb2, Bb3 = 0;
int Eb1, Eb2, Eb3 = 0;
int v1, v2, v3 = 0;
int verse = 0;
int change = 0;
int sensing;

void setup() {
  Serial.begin(9600);
  pinMode(A0, OUTPUT);
  pinMode(A1, OUTPUT);
  pinMode(A2, OUTPUT);
  pinMode(A5, INPUT);
  strip1.begin();
  strip1.show();
  strip1.setBrightness(1);
  strip2.begin();
  strip2.show();
  strip2.setBrightness(1);
  strip3.begin();
  strip3.show();
  strip3.setBrightness(1);

  serial.begin(9600);
}

void loop() {
  if (serial.available() > 0) {
    sensing = serial.read();
  //  Serial.println(sensing);
    if (sensing == 1) {
      change = 1;
      Bb1, Bb2 , Bb3 = 0;
      Eb1, Eb2 , Eb3 = 0;
    } else if (sensing == 2) {
      change = 2;
      Rb1, Rb2, Rb3 = 0;
      Eb1, Eb2 , Eb3 = 0;
    } else if (sensing == 3) {
      change = 3;
      Rb1, Rb2 , Rb3 = 0;
      Bb1, Bb2, Bb3 = 0;
    } else if (sensing == 9) {
      change = 0;
      v1, v2, v3 = 0;
      Rb1, Rb2 , Rb3 = 0;
      Bb1, Bb2 , Bb3 = 0;
      Eb1, Eb2 , Eb3 = 0;
    }
  }

  if (change == 1) {
    verse = 1;
  } else if (change == 2) {
    verse = 2;
  } else if (change == 3) {
    verse = 3;
  }

  if (verse == 1) {
    red();
  } else if (verse == 2) {
    blue();
  } else if (verse == 3) {
    every();
  }


  if (change == 0) {
    for (int i = 0; i < 60; i++) {
      strip1.setPixelColor(i, strip1.Color(0, 0, 0));
      strip2.setPixelColor(i, strip2.Color(0, 0, 0));
      strip3.setPixelColor(i, strip3.Color(0, 0, 0));
    }
    strip1.setBrightness(0);
    strip2.setBrightness(0);
    strip3.setBrightness(0);
    strip1.show();
    strip2.show();
    strip3.show();
  }
}
void red() {
  if (verse == 1) {
    for (int i = 0; i < 60; i++) {
      strip1.setPixelColor(i, strip1.Color(255, 0, 0));
      strip2.setPixelColor(i, strip2.Color(255, 0, 0));
      strip3.setPixelColor(i, strip3.Color(255, 0, 0));
    }
    if (v1 == 0) {
      for (int i = 1; i < 4; i++) {
        Rb1 = 17 * i;
        strip1.setBrightness(Rb1);
        strip2.setBrightness(Rb1);
        strip3.setBrightness(Rb1);
        strip1.show();
        strip2.show();
        strip3.show();

        strip1.setBrightness(1);
        strip2.setBrightness(1);
        strip3.setBrightness(1);
        strip1.show();
        strip2.show();
        strip3.show();

      }
    }
  }
}

void blue() {
  if (verse == 2) {
    for (int i = 0; i < 60; i++) {
      strip1.setPixelColor(i, strip1.Color(0, 0, 255));
      strip2.setPixelColor(i, strip2.Color(0, 0, 255));
      strip3.setPixelColor(i, strip3.Color(0, 0, 255));
    }
    if (v2 == 0) {
      Bb1++;
      Bb2++;
      Bb3++;
      strip1.setBrightness(Bb1);
      strip2.setBrightness(Bb2);
      strip3.setBrightness(Bb3);
      delay(5);
      strip1.show();
      strip2.show();
      strip3.show();
      if (Bb1 == 150 && Bb2 == 150 && Bb3 == 150) {
        v2 = 1;
      }
    }else if (v2 = 1) {
      Bb1--;
      Bb2--;
      Bb3--;
      strip1.setBrightness(Bb1);
      strip2.setBrightness(Bb2);
      strip3.setBrightness(Bb3);
      strip1.show();
      strip2.show();
      strip3.show();
      if (Bb1 == 0 && Bb2 == 0 && Bb3 == 0) {
        v2 = 0;
      }
    }
  }
}
//    else if ( v2 == 2) {
//      Bb1++;
//      Bb2--;
//      Bb3++;
//      strip1.setBrightness(Bb1);
//      strip2.setBrightness(Bb2);
//      strip3.setBrightness(Bb3);
//      //delay(5);
//      strip1.show();
//      strip2.show();
//      strip3.show();
//      if (Bb1 == 255 && Bb2 == 0 && Bb3 == 255) {
//        // delay(1000);
//        v2 = 3;
//
//      }
//    } else if ( v2 == 3) {
//      Bb1--;
//      Bb3--;
//      strip1.setBrightness(Bb1);
//      strip3.setBrightness(Bb3);
//      //delay(5);
//      strip1.show();
//      strip3.show();
//      if (Bb1 == 0 && Bb2 == 0 && Bb3 == 0) {
//        v2 = 4;
//      }
//    } else if ( v2 == 4) {
//      Bb2++;
//      strip2.setBrightness(Bb2);
//      //delay(5);
//      strip2.show();
//      if (Bb1 == 0 && Bb2 == 255 && Bb3 == 0) {
//        v2 = 5;
//      }
//    } else if ( v2 == 5) {
//      Bb1++;
//      Bb3++;
//      strip1.setBrightness(Bb1);
//      strip3.setBrightness(Bb3);
//      //delay(20);
//      strip1.show();
//      strip3.show();
//      if ( Bb1 == 255 && Bb2 == 255 && Bb3 == 255) {
//        v2 = 6;
//      }
//    } else if (v2 == 6) {
//      Bb1--;
//      Bb2--;
//      Bb3--;
//      strip1.setBrightness(Bb1);
//      strip2.setBrightness(Bb2);
//      strip3.setBrightness(Bb3);
//      //delay(5);
//      strip1.show();
//      strip2.show();
//      strip3.show();
//
//      if (Bb1 == 0 && Bb2 == 0 & Bb3 == 0) {
//        delay(1000);
//        v2 = 0;
//      }
//    }
//  }
void every() {
  if (verse == 3) {
    for (int i = 0; i < 60; i++) {
      strip1.setPixelColor(i, strip1.Color(150, 0, 50));
      strip2.setPixelColor(i, strip2.Color(0, 200, 102));
      strip3.setPixelColor(i, strip3.Color(200, 228, 0));
    }
    if (v3 == 0) {
      strip1.setBrightness(45);
      strip2.setBrightness(45);
      strip3.setBrightness(45);
      strip1.show();
      strip2.show();
      strip3.show();
    }
  }
}
//    else if (v3 == 1) {
//      Eb1--;
//      Eb2--;
//      Eb3--;
//      strip1.setBrightness(Eb1);
//      strip2.setBrightness(Eb2);
//      strip3.setBrightness(Eb3);
//      strip1.show();
//      strip2.show();
//      strip3.show();
//      if (Eb1 == 1 && Eb2 == 1 && Eb3 == 1 ) {
//        v3 = 0;
//      }
//    }
