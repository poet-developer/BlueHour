#include <Adafruit_NeoPixel.h>

#define PIN1 A0
#define PIN2 A2
#define PIN3 A1
//data out이 연결된 핀 번호
#define NUM_LEDS 60

int b1 = 0;
int b2 = 0;
int b3 = 0;
int v = 0;
int verse = 0;
int change = 0;
int redV = 1;

Adafruit_NeoPixel strip1 = Adafruit_NeoPixel(NUM_LEDS, PIN1, NEO_GRBW + NEO_KHZ800);
Adafruit_NeoPixel strip2 = Adafruit_NeoPixel(NUM_LEDS, PIN2, NEO_GRBW + NEO_KHZ800);
Adafruit_NeoPixel strip3 = Adafruit_NeoPixel(NUM_LEDS, PIN3, NEO_GRB + NEO_KHZ800);

void setup() {
  Serial.begin(9600);
  pinMode(A0, OUTPUT);
  pinMode(A1, OUTPUT);
  pinMode(A2, OUTPUT);

  strip1.begin();
  strip1.show();
  strip1.setBrightness(1);
  strip2.begin();
  strip2.show();
  strip2.setBrightness(1);
  strip3.begin();
  strip3.show();
  strip3.setBrightness(1);
}

void loop() {
  for (int i = 0; i < 60; i++) {
    for (int i = 0; i < 60; i++) {
      strip1.setPixelColor(i, strip1.Color(150, 0, 50));
      strip2.setPixelColor(i, strip2.Color(0, 200, 102));
      strip3.setPixelColor(i, strip3.Color(200, 228, 0));
    }
  }
  if (v == 0) {
    b1++;
    b2++;
    b3++;
    strip1.setBrightness(b1);
    strip2.setBrightness(b2);
    strip3.setBrightness(b3);
    strip1.show();
    strip2.show();
    strip3.show();
    if ( b1 == 50) {
    v = 1;
  }
  }

if (v == 1) {
    b1--;
    b2--;
    b3--;
    strip1.setBrightness(b1);
    strip2.setBrightness(b2);
    strip3.setBrightness(b3);
    strip1.show();
    strip2.show();
    strip3.show();
  if(b1 ==1){
    v=0;
  }
  
  }
}
