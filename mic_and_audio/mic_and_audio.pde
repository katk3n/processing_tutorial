import ddf.minim.analysis.*;
import ddf.minim.*;

Minim minim;
AudioPlayer player;
AudioInput in;
FFT fftPlayer, fftIn;
int fftSize;

void setup() {
  size(640, 480, P2D);
  noStroke();
  blendMode(ADD);
  colorMode(HSB, 360, 100, 100, 100);

  minim = new Minim(this);
  fftSize = 512;

  in = minim.getLineIn(Minim.STEREO, 512);
  player = minim.loadFile("/Users/kentaktwo/Desktop/impro10.mp3", fftSize);
  player.loop();
  fftPlayer = new FFT(player.bufferSize(), player.sampleRate());
  fftIn = new FFT(in.bufferSize(), in.sampleRate());
}

void draw() {
  background(0);

  // specSize() gets spectrum width
  int specSizePlayer = fftPlayer.specSize();
  int specSizeIn = fftIn.specSize();

  fftPlayer.forward(player.mix);
  for (int i = 0; i < specSizePlayer; i++) {
    float h = map(i, 0, specSizePlayer, 0, 180);
    float ellipseSize = map(fftPlayer.getBand(i), 0, fftSize/16, 0, width);
    float x = map(i, 0, specSizePlayer, width/3, 0);
    float w = width / float(specSizePlayer) / 2;
    fill(h, 80, 80, 7);
    ellipse(x, height/2, ellipseSize, ellipseSize);
  }

  fftIn.forward(in.mix);
  for (int i = 0; i < specSizeIn; i++) {
    float h = map(i, 0, specSizeIn, 180, 360);
    float ellipseSize = map(fftIn.getBand(i), 0, fftSize/16, 0, width);
    float x = map(i, 0, specSizeIn, (width * 2)/3, width);
    float w = width / float(specSizeIn) / 2;
    fill(h, 80, 80, 7);
    ellipse(x, height/2, ellipseSize, ellipseSize);
  }

}

void stop() {
  player.close();
  in.close();
  minim.stop();
  super.stop();
}