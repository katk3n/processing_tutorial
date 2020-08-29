import ddf.minim.analysis.*;
import ddf.minim.*;

int FFTSIZE = 8192;
Minim minim;
AudioPlayer player;
FFT fft;

float CAMERA_RADIOUS = 1000;
float CAMERA_RADIAN_SPEED = PI / 256;
float radian1;
float radian2;

float centerX;
float centerY;
float centerZ;


void setup() {
  // Object
  size(600, 600, P3D);
  smooth();
  frameRate(60);
  colorMode(HSB, 360, 100, 100, 100);
  noStroke();
  background(0);
  minim = new Minim(this);
  player = minim.loadFile("/Users/kentaktwo/Desktop/impro10.mp3");
  player.loop();
  fft = new FFT(player.bufferSize(), FFTSIZE);

  // Camera
  radian1 = random(PI * 2);
  radian2 = random(PI * 2);
  
  centerX = width/2;
  centerY = height/2;
  centerZ = height/2;
}

void draw() {
  background(0);
  blendMode(ADD);
  translate(width/2, height/2);
  fft.forward(player.mix);
  int specSize = fft.specSize();
  float getBand;

  if (keyPressed) {
    if (keyCode == LEFT) {
      radian1 += CAMERA_RADIAN_SPEED;
    }
    if (keyCode == RIGHT) {
      radian1 -= CAMERA_RADIAN_SPEED;
    }
    if (keyCode == UP) {
      radian2 += CAMERA_RADIAN_SPEED;
    }
    if (keyCode == DOWN) {
      radian2 -= CAMERA_RADIAN_SPEED;
    }
  }

  float cameraX = CAMERA_RADIOUS * sin(radian1) * cos(radian2);
  float cameraY = CAMERA_RADIOUS * sin(radian1) * sin(radian2);
  float cameraZ = CAMERA_RADIOUS * cos(radian1);
  
  camera(centerX + cameraX, centerY + cameraY, centerZ + cameraZ, centerX, centerY, centerZ, 0, 1, 0);
  pushMatrix();
  translate(centerX, centerY, centerZ);

  for (int i = 0; i < specSize; i++) {
    getBand = fft.getBand(i);
    fill(255, 20);
    float h = map(i * 8, 0, specSize, 120, 300);
    float r = getBand * i / 8.0 + 100.0;
    fill(h, 100, 100, 10);
    box(r, r, r);
  }

  popMatrix();
  updateCamera();
}

void updateCamera(){
  radian1 += CAMERA_RADIAN_SPEED;
  radian2 += CAMERA_RADIAN_SPEED;
  if(radian1 < 0){
    radian1 += PI * 2;
  } else if(radian1 >= PI * 2){
    radian1 -= PI * 2;
  }
  if(radian2 < 0){
    radian2 += PI * 2;
  } else if(radian2 >= PI * 2){
    radian2 -= PI * 2;
  }
}  