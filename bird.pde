class Bird {
  float x;
  float y;
  float size = 40;
  float vy = 0;
  float ay = 0.2;
  PImage bird;

  Bird(float initialX, float initialY) {
    x = initialX;
    y = initialY;
    bird = loadImage("bird.png");
  }

  /**
   Metoda koja crta "pticu" i osvježava
   njenu poziciju na ekranu.
   - nema parametara
   - nema povratne vrijednosti
  */
  void draw() {
    pushStyle();

    imageMode(CENTER);
    image(bird, x, y, size, size);

    popStyle();

    y += vy;
    vy += ay;
  }

  void reset() {
    y = 0;
    vy = 0;
  }

  void jump() {
    vy = -4;
  }
}
