class AudioEllipse {

  // super class of AudioPlayer, AudioInput, etc.
  AudioSource source;

  FFT fft;
  int fftSize;
  int colorMin, colorMax;
  float rangeMin, rangeMax;

  AudioEllipse(AudioSource source, int fftSize,
               int colorMin, int colorMax,
               float rangeMin, float rangeMax) {
    this.source = source;
    this.fft = new FFT(source.bufferSize(), source.sampleRate());
    this.fftSize = fftSize;
    this.colorMin = colorMin;
    this.colorMax = colorMax;
    this.rangeMin = rangeMin;
    this.rangeMax = rangeMax;
  }

  void draw() {
    fft.forward(source.mix);
    int specSize = fft.specSize();
    for (int i = 0; i < specSize; i++) {
      float h = map(i, 0, specSize, colorMin, colorMax);
      float ellipseSize = map(fft.getBand(i), 0, fftSize/16, 0, width);
      float x = map(i, 0, specSize, rangeMin, rangeMax);
      float w = width / float(specSize) / 2;
      fill(h, 80, 80, 7);
      ellipse(x, height/2, ellipseSize, ellipseSize);
    }
  }
}