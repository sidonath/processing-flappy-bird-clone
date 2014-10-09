class Obstacle {
  float topX;
  float topY;
  float w = 50;

  Obstacle(float initialTopX, float initialTopY) {
    topX = initialTopX;
    topY = initialTopY;
  }

  /**
     Metoda koja crta "cijev" i osvježava
     njenu poziciju na ekranu. Kada cijev nestane
     s ekrana, vraćamo je na početak.
     - nema parametara
     - nema povratne vrijednosti
  */
  void draw() {
    // CORNERS mod je praktičan za crtanje cijevi
    // jer možemo direktno odrediti na kojim
    // koordinatama cijev počinje i gdje završava.
    rectMode(CORNERS);
    fill(#49D37A);
    rect(topX, topY, topX+w, height-1);
    topX -= 1;

    if (topX + w < 0) {
      reset();
    }
  }

  void reset() {
    topX = width;
    topY = random(100, height-100);
  }
}
