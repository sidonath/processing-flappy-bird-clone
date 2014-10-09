Bird bird;
Obstacle obstacle;
// Stanje igre
boolean gameOver = false;

void setup() {
  size(300, 400);
  bird = new Bird(width/2, 0);
  obstacle = new Obstacle(width, random(100, height-100));
}

void draw() {
  background(#50BDFF);

  if (gameOver) {
    drawGameOver();
  } else {
    bird.draw();
    obstacle.draw();
    detectCollision();
  }
}

/**
   Pritisak dugmeta miša na Game over
   ekranu pokreće igru ponovo.
   Tokom igre, "ptica" poleti u zrak početnom
   brzinom od 5px/frame.
*/
void mousePressed() {
  if (gameOver) {
    gameOver = false;
    bird.reset();
    obstacle.reset();
  } else {
    bird.vy = -5;
  }
}

/**
   Funkcija koja crta ekran za kraj igre
   - nema parametara
   - nema povratne vrijednosti
*/
void drawGameOver() {
  rectMode(CENTER);
  textSize(32);
  textAlign(CENTER, CENTER);
  fill(0);
  text("Game over!",
       width/2, height/2,
       width, 100);
}

/**
   Funkcija koja detektuje "sudare" i u
   slučaju sudara prebacuje igru u stanje
   "Game over", podešavajući globalnu boolean
   varijablu.
   Funkcija provjerava da li je ptica izašla
   van okvira ekrana i da li je ptica udarila
   u cijev.
   - nema parametara
   - nema povratne vrijednosti
*/
void detectCollision() {
  // Da li je ptica izašla iz ekrana?
  if (bird.y > height) {
    gameOver = true;
  }

  if (rectsCollide(bird.x, bird.y, bird.size, bird.size,
                   obstacle.topX, obstacle.topY, obstacle.topX+obstacle.w, height-1)) {
    gameOver = true;
  }
}

boolean rectsCollide(float firstX, float firstY, float firstWidth, float firstHeight,
                     float secondULX, float secondULY, float secondBRX, float secondBRY) {
  float hh = firstHeight/2;
  float hw = firstWidth/2;
  return isInside(firstX - hw, firstY - hh, secondULX, secondULY, secondBRX, secondBRY) ||
         isInside(firstX + hw, firstY - hh, secondULX, secondULY, secondBRX, secondBRY) ||
         isInside(firstX + hw, firstY + hh, secondULX, secondULY, secondBRX, secondBRY) ||
         isInside(firstX - hw, firstY + hh, secondULX, secondULY, secondBRX, secondBRY);
}

boolean isInside(float x, float y, float ulX, float ulY, float brX, float brY) {
  return (x >= ulX && x <= brX && y >= ulY && y <= brY);
}
