class AudioEllipse {

  // super class of AudioPlayer, AudioInput, etc.
  SoundObject source;

  FFT fft;
  Amplitude amp;
  int bands = 512;
  int colorMin, colorMax;
  float rangeMin, rangeMax;
  float[] spectrum = new float[bands];

  AudioEllipse(PApplet parent, SoundObject source,
               int colorMin, int colorMax,
               float rangeMin, float rangeMax) {
    this.source = source;
    this.fft = new FFT(parent);
    this.fft.input(source);
    this.amp = new Amplitude(parent);
    this.amp.input(source);
    this.colorMin = colorMin;
    this.colorMax = colorMax;
    this.rangeMin = rangeMin;
    this.rangeMax = rangeMax;
  }

  void draw() {
    fft.analyze(spectrum);
    for (int i = 0; i < bands; i++) {
      float h = map(i, 0, bands, colorMin, colorMax);
      float diameter = map(spectrum[i], 0, 1, 0, width * 2);
      float x = map(i, 0, bands, rangeMin, rangeMax);
      fill(h, 80, 80, 7);
      ellipse(x, height/2, diameter, diameter);
    }
  }
}