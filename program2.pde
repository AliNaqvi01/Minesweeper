int x = 25;
int y = 25;
int count = 0;
int z = 0;
Boolean run = true;

Tile breath[][] = new Tile [x][y];

// All classes defined here


class Tile {
  // the tile class holds infomration about each tile
  // shade is the color, hot is if it is a mine, count is the number of adjacent mines, broken if it is "broken", isClicked if it has been clicked
  boolean hot;
  boolean broken;
  boolean isClicked;
  int shade;
  int count;


  Tile(boolean h, int s, int t, boolean m) {
    this.hot = h;
    this.shade = s;
    this.count = t;
    this.broken = m;
  }
}

// All functions defined here

void restart() {
}

void showNumber() {
  // showNumber shows the count of adjacent mines on each tile
  for (int i = 0; i < 25; i++) {
    for (int j = 0; j < 25; j++) {
      if (breath[i][j].isClicked) {
        text(breath[i][j].count, i*20, j*20+20);
      }
      if (breath[i][j].broken && i > 0 && j > 0 && i < 24 &&   j < 24 && ((breath[i][j-1].broken == false)|| (breath[i][j+1].broken == false) ||( breath[i+1][j].broken == false )||( breath[i-1][j].broken == false))) {
        fill(255, 255, 255);
        text(breath[i][j].count, i*20, j*20+20);
      }
      if (i == 0 && breath[i][j].broken) {
        fill(255, 255, 255);
        text(breath[i+1][j].count, i*20, j*20+20);
      }
      if (j == 0 && breath[i][j].broken) {
        fill(255, 255, 255);
        text(breath[i][j+1].count, i*20, j*20+20);
      }
      if (i == 24 && breath[i][j].broken) {
        fill(255, 255, 255);
        text(breath[i-1][j].count, i*20, j*20+20);
      }
      if (j == 24 && breath[i][j].broken) {
        fill(255, 255, 255);
        text(breath[i][j-1].count, i*20, j*20+20);
      }
    }
  }
}


// breakBoard is the first step to starting the game
// it "break" a section of the map
void breakBoard() {
  // boolean logic makes sure that breakBoard only works once every game
  if (run) {
    run = !run;
    for (int i = 0; i < 25; i++) {
      for (int j = 0; j < 25; j++) {
        if (mouseX > i*20 && mouseX < i*20+20 && mouseY > j*20 && mouseY < j*20+20) {
          for (int k = 0; k < 10; k++) {
            for (int l = 0; l < 10; l++) {
              // these loops "break" a 10x10 section of the map starting from where you click
              if (i+k < 25 && j+l < 25) { 
                breath[i+k][j].shade = 0;
                breath[i+k][j+l].shade = 0;
                breath[i+k][j].broken = true;
                breath[i+k][j+l].broken = true;
              }
            }
          }
        }
      }
    }
  }
}

void setup() {
  size(500, 500);
  for (int i = 0; i < x; i++) {
    for (int j = 0; j < y; j++) {
      breath[i][j] = new Tile(false, 0, 0, false);
      breath[i][j].shade = 300;
      breath[i][j].isClicked = false;
      // makes every 1 in 5 blocks on random to be mines
      if (int(floor(random(2))) == 1) {
        breath[i][j].hot = true;
      } else {
        breath[i][j].hot = false;
      }
    }
  }
  for (int i = 1; i < 24; i++) {
    for (int j = 1; j < 24; j++) {

      if (breath[i+1][j].hot) {
        breath[i][j].count++;
      }
      if (breath[i-1][j].hot) {
        breath[i][j].count++;
      }
      if (breath[i][j-1].hot) {
        breath[i][j].count++;
      }
      if (breath[i][j+1].hot) {
        breath[i][j].count++;
      }
      if (breath[i-1][j+1].hot) {
        breath[i][j].count++;
      }
      if (breath[i-1][j-1].hot) {
        breath[i][j].count++;
      }
      if (breath[i+1][j+1].hot) {
        breath[i][j].count++;
      }
      if (breath[i+1][j-1].hot) {
        breath[i][j].count++;
      }
    }
  }
}

void draw() {
  frameCount++;
  for (int i = 0; i < x; i++) {
    for (int j = 0; j < x; j++) {
      fill(breath[i][j].shade);
      rect(i*20, j*20, 20, 20);
      fill(178, 34, 34);
    }
  }
  textSize(14);
  showNumber();
}


void mousePressed() {

  if (mouseButton == RIGHT) {
    breakBoard();
  }

  for (int i = 0; i < 25; i++) {
    for (int j = 0; j < 25; j++) {
      if (mouseButton == LEFT && mouseX > i*20 && mouseX < i*20+20 && mouseY > j*20 && mouseY < j*20+20 && breath[i][j].hot) {
        breath[i][j].shade = 10;
      }
      if (mouseButton == LEFT && mouseX > i*20 && mouseX < i*20+20 && mouseY > j*20 && mouseY < j*20+20 && !breath[i][j].hot) {
        breath[i][j].shade = 255;
        breath[i][j].isClicked = true;
      }
    }
  }
}
