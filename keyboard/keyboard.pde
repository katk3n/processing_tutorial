/**
* sample01
*/

import ddf.minim.spi.*;
import ddf.minim.signals.*;
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.ugens.*;
import ddf.minim.effects.*;

Minim minim;
AudioOutput out;

void setup(){
  size(600, 400);
  minim = new Minim(this);
  out = minim.getLineOut();
}

void draw(){

}

void keyPressed(){
  String pitchName = "";
  switch(key){
  case 'z':
    pitchName += "C"; break;
  case 's':
    pitchName += "C#"; break;
  case 'x':
    pitchName += "D"; break;
  case 'd':
    pitchName += "D#"; break;
  case 'c':
    pitchName += "E"; break;
  case 'v':
    pitchName += "F"; break;
  case 'g':
    pitchName += "F#"; break;
  case 'b':
    pitchName += "G"; break;
  case 'h':
    pitchName += "G#"; break;
  case 'n':
    pitchName += "A"; break;
  case 'j':
    pitchName += "A#"; break;
  case 'm':
    pitchName += "B"; break;
  }
  if(pitchName != ""){
    out.playNote(0.0, 0.1, new Keyboard(Frequency.ofPitch(pitchName + "4").asHz()));
  }
}

class Keyboard implements Instrument {
  
  Oscil osc;
  
  Keyboard(float pitch){
    osc = new Oscil(pitch, 1.0, Waves.SAW);
  }
  
  void noteOn(float duration){
    osc.patch(out);  
  }
  
  void noteOff(){
    osc.unpatch(out);
  }
  
}