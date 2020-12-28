import processing.sound.*;
SoundFile file;
AudioIn in;
AudioEllipse fileEllipse;
AudioEllipse inEllipse;

void setup() {
  fullScreen(P2D);
  noStroke();
  blendMode(ADD);
  colorMode(HSB, 360, 100, 100, 100);
  
  file = new SoundFile(this, "/Users/kentaktwo/Desktop/impro10.mp3");
  file.loop();
  fileEllipse = new AudioEllipse(this, file, 0, 180, width/3, 0);
  in = new AudioIn(this, 0);
  inEllipse = new AudioEllipse(this, in, 180, 360, (width*2)/3, width);
}

void draw() {
  background(0);
  fileEllipse.draw();
  inEllipse.draw();
}