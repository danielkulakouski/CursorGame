int numFrames = 4;
PImage [] images = new PImage [numFrames];
int currentFrame = 1;

void poof() {
  image(images[currentFrame], ballX[l], ballY[l]);
  currentFrame++;
  if (currentFrame>=images.length) {
    ballH = false;
  }
}