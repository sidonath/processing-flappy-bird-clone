// Osobine ptice
float birdX = 150;
float birdY = 0;
float birdSize = 20;

float vy = 0;    // brzina
float ay = 0.2;  // ubrzanje (gravitacija)

// Osobine prepreka ("cijevi")
float obstacleTopX;
float obstacleTopY;
float obstacleWidth = 50;

// Stanje igre
boolean gameOver = false;

void setup() {
  size(300, 400);

  // Slučajno biramo visinu prepreke
  obstacleTopX = width;
  obstacleTopY = random(100, height-100);
}

void draw() {
  background(#50BDFF);

  if (gameOver) {
    drawGameOver();
  } else {
    drawBird();
    drawObstacle();
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
    birdY = 0;
    vy = 0;
  } else {
    vy = -5;
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
   Funkcija koja crta "pticu" i osvježava
   njenu poziciju na ekranu.
   - nema parametara
   - nema povratne vrijednosti
*/
void drawBird() {
  fill(255);
  ellipse(birdX, birdY, birdSize, birdSize);

  birdY += vy;
  vy += ay;
}

/**
   Funkcija koja crta "cijev" i osvježava
   njenu poziciju na ekranu. Kada cijev nestane
   s ekrana, vraćamo je na početak.
   - nema parametara
   - nema povratne vrijednosti
*/
void drawObstacle() {
  // CORNERS mod je praktičan za crtanje cijevi
  // jer možemo direktno odrediti na kojim
  // koordinatama cijev počinje i gdje završava.
  rectMode(CORNERS);
  fill(#49D37A);
  rect(obstacleTopX, obstacleTopY,
       obstacleTopX+obstacleWidth, height-1);

  obstacleTopX -= 1;

  if (obstacleTopX + obstacleWidth < 0) {
    obstacleTopX = width;
    obstacleTopY = random(100, height-100);
  }
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
  if (birdY > height) {
    gameOver = true;
  }

  if (rectsCollide(birdX, birdY, birdSize, birdSize,
                   obstacleTopX, obstacleTopY, obstacleTopX+obstacleWidth, height-1)) {
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
