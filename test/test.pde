
int x, y;

void setup() {
  size(800, 600);
  x = 200;
  y = 10;
}

void draw() {
  background(0);
  stroke(100,100,100);
  fill(255,255,255,255);
  ellipse(x,y,100,100);

  fill(100,255,255,255);
  ellipse(x,200,200,200);

  x++;
  y++;
  if (x > 800) {
    x = 0;
  }
  if (y > 600) {
    y = 0;
  }
}