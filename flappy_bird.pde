float y = 0;
float vy = 0;
float ay = 0.2;

void setup() {
  size(800, 600);
}

void draw() {
  background(255);
  ellipse(400, y, 50, 50);
  y += vy;
  vy += ay;
}

void mousePressed() {
  vy = -10;
}

