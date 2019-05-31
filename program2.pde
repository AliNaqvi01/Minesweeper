int x = 25;
int y = 25;
int count = 0;
int z = 0;
Boolean run = true;

Tile breath[][] = new Tile [x][y];

// All classes defined here

// the tile class holds infomration about each tile
class Tile {
  // shade is the color, hot is if it is a mine, count is the number of adjacent mines
  boolean hot;
  int shade;
  int count;

  Tile(boolean h, int s, int t) {
    this.hot = h;
    this.shade = s;
    this.count = t;
  }
}

// All functions defined here

// hide shows the count of adjacent mines on each tile
void hide(Boolean x) {
  if (!x) {
    for (int i = 0; i < 25; i++) {
      for (int j = 0; j < 25; j++) {
        fill(138, 43, 226);
        text(breath[i][j].count, i*20, j*20);
      }
    }
  }
}

// breaker is the first step to starting the game
// it "break" a section of the map
void breaker() {
  // boolean logic makes sure that breaker only works once every game
  if (run) {
    run = !run;
    for (int i = 0; i < 25; i++) {
      for (int j = 0; j < 25; j++) {
        if (mouseX > i*20 && mouseX < i*20+20 && mouseY > j*20 && mouseY < j*20+20) {
          for (int k = 0; k < 10; k++) {
            for (int l = 0; l < 10; l++) {
              // these loops "break" a 10x10 section of the map starting from where you click
              if (i+k < 25 && j+l < 25) { 
                breath[i+k][j].shade = 50;
                breath[i+k][j+l].shade = 50;
              }
            }
          }
        }
      }
    }
  }
}

void setup() {
  size(500, 481 );
  for (int i = 0; i < x; i++) {
    for (int j = 0; j < y; j++) {
      breath[i][j] = new Tile(false, 0, 0);
      breath[i][j].shade = 300;
      // makes every 1 in 5 blocks on random to be mines
      if (int(floor(random(5))) == 1) {
        breath[i][j].hot = true;
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
  for (int i = 0; i < x; i++) {
    for (int j = 0; j < x; j++) {
      fill(breath[i][j].shade);
      rect(i*20, j*20, 20, 20);
      fill(178, 34, 34);
    }
  }
  textSize(20);
  hide(false);
}


void mousePressed() {

  if (mouseButton == RIGHT) {
    breaker();
  }

  for (int i = 0; i < 25; i++) {
    for (int j = 0; j < 25; j++) {
      if (mouseButton == LEFT && mouseX > i*20 && mouseX < i*20+20 && mouseY > j*20 && mouseY < j*20+20 && breath[i][j].hot) {
        breath[i][j].shade = 10;
      }
    }
  }
}
