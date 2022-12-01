import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

AudioPlayer morning;

void setup(){
  Minim minim = new Minim(this);
  morning = minim.loadFile( "morning.mp3");
}

void draw(){
  morning.play();
}
