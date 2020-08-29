import ddf.minim.analysis.*;
import ddf.minim.*;

Minim minim;
AudioPlayer player;
AudioInput in;
AudioEllipse playerEllipse, micEllipse;
static final int FFT_SIZE = 512;

void setup() {
  fullScreen(P2D);
  noStroke();
  blendMode(ADD);
  colorMode(HSB, 360, 100, 100, 100);

  minim = new Minim(this);
  player = minim.loadFile("/Users/kentaktwo/Desktop/impro10.mp3", FFT_SIZE);
  in = minim.getLineIn(Minim.STEREO, FFT_SIZE);
  player.loop();
  playerEllipse = new AudioEllipse(player, FFT_SIZE, 0, 180, width/3, 0);
  micEllipse = new AudioEllipse(in, FFT_SIZE, 180, 360, (width*2)/3, width);
}

void draw() {
  background(0);
  playerEllipse.draw();
  micEllipse.draw();
}

void stop() {
  player.close();
  in.close();
  minim.stop();
  super.stop();
}