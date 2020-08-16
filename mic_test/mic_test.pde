import processing.sound.*;

AudioIn input;
Amplitude analyzer;

void setup() {
  size(500, 500);

  // Start listening to the microphone
  // Create an Audio input and grab the 1st channel
  input = new AudioIn(this, 0);

  // start the Audio Input
  input.start();

  // create a new Amplitude analyzer
  analyzer = new Amplitude(this);

  // Patch the input to an volume analyzer
  analyzer.input(input);
}

void draw() {
  float randR, randG, randB;

  // Get the overall volume (between 0 and 1.0)
  float vol = analyzer.analyze();
  
  randR = int(vol * 200 + 50);
  randG = int(vol * 255);
  randB = int(vol * 255);
  
  background(randR, randG, randB);
  fill(200, 0, 0);
  stroke(10);
  
  ellipse(height/2, width/2, 50 + vol * random(100), 50 + vol * 100);
  
  
}