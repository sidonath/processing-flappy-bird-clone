class Bird {
  float x;
  float y;
  float size = 20;
  float vy = 0;
  float ay = 0.2;

  Bird(float initialX, float initialY) {
    x = initialX;
    y = initialY;
  }

  /**
   Metoda koja crta "pticu" i osvježava
   njenu poziciju na ekranu.
   - nema parametara
   - nema povratne vrijednosti
  */
  void draw() {
    fill(255);
    ellipse(x, y, size, size);

    y += vy;
    vy += ay;
  }

  void reset() {
    y = 0;
    vy = 0;
  }
}
