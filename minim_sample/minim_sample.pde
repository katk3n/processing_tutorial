import ddf.minim.analysis.*;
import ddf.minim.*;

Minim minim;
AudioPlayer player;
FFT fft;

int fftSize;
float radius = 150;

void setup() {
  size(640, 480, P2D);
  noStroke();
  blendMode(ADD);
  colorMode(HSB, 360, 100, 100, 100);

  minim = new Minim(this);
  fftSize = 512;

  player = minim.loadFile("/Users/kentaktwo/Desktop/impro10.mp3", fftSize);
  player.loop();
  fft = new FFT(player.bufferSize(), player.sampleRate());
}

void draw() {
  background(0);

  // specSize() gets spectrum width
  int specSize = fft.specSize();

  // player.mix: mix both left & right sound source
  // player.left: use only left sound source
  // player.right: use only right sound source
  fft.forward(player.left);
  for (int i = 0; i < specSize; i++) {
    float h = map(i, 0, specSize, 0, 180);
    // getBand() gets sound volume
    float ellipseSize = map(fft.getBand(i), 0, fftSize/16, 0, width);
    float x = map(i, 0, specSize, width/2, 0);
    float w = width / float(specSize) / 2;
    fill(h, 80, 80, 7);
    ellipse(x, height/2, ellipseSize, ellipseSize);
  }

  fft.forward(player.right);
  for (int i = 0; i < specSize; i++) {
    float h = map(i, 0, specSize, 0, 180);
    // getBand() gets sound volume
    float ellipseSize = map(fft.getBand(i), 0, fftSize/16, 0, width);
    float x = map(i, 0, specSize, width/2, width);
    float w = width / float(specSize) / 2;
    fill(h, 80, 80, 7);
    ellipse(x, height/2, ellipseSize, ellipseSize);
  }

}