int num = 100;
int ballsHit = 0;
PImage yu;
PImage cursor;
float [] ballX = new float [num];
float [] ballY = new float [num];
float [] speedX = new float [num];
float [] speedY = new float [num];
float [] hue = new float [num];
float [] size = new float [num];
boolean gameOver = false;
PFont myFont;
int mSize = 20;
boolean alive = true;
boolean start = false;
String string = "Press Any Key To Begin";
boolean [] balls = new boolean[num];
float x;
float y;
float lerpX;
float lerpY;
boolean gg = false;
boolean ballH = false;
int l;

void setup() {
  size(600, 600);
  colorMode(HSB);
  myFont = loadFont("HoboStd-48.vlw");
  textFont(myFont);

  yu = loadImage("yu.png");
  yu.resize(100, 100);

  cursor = loadImage("cursor.png");
  cursor.resize(50, 50);

  for (int i = 0; i<num; i++) {
    ballX[i] = random(width);
    ballY[i] = random(height);
    hue[i] = random(255);
    size[i] = random(40);
    speedX[i] = random(-1, 1);
    speedY[i] = random(-1, 1);
    balls[i] = true;
    if (speedX[i]==0) {
      speedX[i] = 5;
    }
    if (speedY[i]==0) {
      speedY[i] = 5;
    }
    if (size[i]<5 && size[i]>0) {
      size[i] = 20;
    }
  }
  for (int i = 1; i<images.length; i++) {
    String imageName = "frame" + nf(i, 4) + ".png";
    imageMode(CENTER);
    images[i] = loadImage(imageName);
    images[i].resize(int(size[i]+5), int(size[i]+5));
  }
  //frameRate(12);
}

void draw() {
  lerpX = lerp(x, height/2, 0.02);
  lerpY = lerp(y, height/2, 0.02);

  //if(start==false||alive==false) {
  //  cursor(cursor);
  //}

  colorMode(HSB);
  noStroke();
  background(0);
  textAlign(CENTER);
  textSize(50);
  fill(255);
  text(string, width/2, height/2);
  if (keyPressed==true) {
    start = true;
    string = "";
  }
  if (start==true) {
    x = mouseX;
    y = mouseY;

    if (alive==true) {
      strokeWeight(mSize/10);
      stroke(abs(mouseX-pmouseX)*6, 255, 255);
      fill(mouseX/2, 255, 255);
      ellipse(x, y, mSize, mSize);
      noCursor();
    }

    for (int i = 0; i<num; i++) {
      if (balls[i] == true) {
        noStroke();
        fill(hue[i], 255, 255);
        ellipse(ballX[i], ballY[i], size[i], size[i]);
        ballX[i] += speedX[i];
        ballY[i] += speedY[i];

        if (ballX[i]-20<=0) {
          speedX[i] *= -1;
        }
        if (ballX[i]+20>=width) {
          speedX[i] *= -1;
        }
        if (ballY[i]-20<=0) {
          speedY[i] *= -1;
        }
        if (ballY[i]+20>=height) {
          speedY[i] *= -1;
        }
      }

      if (balls[i] == true && mouseX+mSize/2>=ballX[i]-size[i]/2 && mouseX-mSize/2<=ballX[i]+size[i]/2) {
        if (mouseY+mSize/2>=ballY[i]-size[i]/2 && mouseY-mSize/2<=ballY[i]+size[i]/2) {
          if (mSize>=size[i]) {
            poof();
            mSize+=size[i]/15;
            balls [i] = false;
            i = l;
            ballsHit++;
          }
          if (mSize<size[i]) {
            gameOver = true;
          }
        }
      }
      if (gameOver==true) {
        gameOver();
      }
    }
  }
  if (gg==true) {
    winner();
  }
  if (ballsHit==num) {
    gg = true;
  }
}

void gameOver() {
  alive=false;
  cursor();
  fill(255);
  textAlign(CENTER);
  textSize(50);
  text("Game Over!\nPress 'r' To Restart", width/2, height/2);
  if (keyPressed==true && key=='r') {
    gameOver = false;
    alive = true;
    noCursor();
  }
}

void winner() {
  x = lerpX;
  y = lerpY;
  if ((lerpX >= width/2-10 && lerpX <= width/2+10) && (lerpY >= height/2-10 && lerpY <= height/2+10)) {
    imageMode(CENTER);
    image(yu, lerpX, lerpY);
    textAlign(CENTER);
    textSize(30);
    fill(255);
    text("Y U SO GOOD AT THIS?", lerpX, lerpY+120);
  }
}