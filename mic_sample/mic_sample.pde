import ddf.minim.analysis.*;
import ddf.minim.*;

Minim minim;
AudioInput in;
FFT fft;
int fftSize;

void setup() {
  size(640, 480, P2D);
  noStroke();
  blendMode(ADD);
  colorMode(HSB, 360, 100, 100, 100);

  minim = new Minim(this);
  fftSize = 512;

  in = minim.getLineIn(Minim.STEREO, 512);
  fft = new FFT(in.bufferSize(), in.sampleRate());
}

void draw() {
  background(0);

  // specSize() gets spectrum width
  int specSize = fft.specSize();

  fft.forward(in.left);
  for (int i = 0; i < specSize; i++) {
    float h = map(i, 0, specSize, 0, 360);
    // getBand() gets sound volume
    float ellipseSize = map(fft.getBand(i), 0, fftSize/16, 0, width);
    float x = map(i, 0, specSize, width/2, 0);
    float w = width / float(specSize) / 2;
    fill(h, 80, 80, 7);
    ellipse(x, height/2, ellipseSize, ellipseSize);
  }

  fft.forward(in.right);
  for (int i = 0; i < specSize; i++) {
    float h = map(i, 0, specSize, 0, 360);
    // getBand() gets sound volume
    float ellipseSize = map(fft.getBand(i), 0, fftSize/16, 0, width);
    float x = map(i, 0, specSize, width/2, width);
    float w = width / float(specSize) / 2;
    fill(h, 80, 80, 7);
    ellipse(x, height/2, ellipseSize, ellipseSize);
  }

}

void stop() {
  in.close();
  minim.stop();
  super.stop();
}