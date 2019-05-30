int x = 25;
int y = 25;
Tile breath[][] = new Tile [x][y];

class Tile {
  boolean hot;
  int shade;
  
  Tile(boolean h, int s) {
    this.hot = h;
    this.shade = s;
  }
}


void setup() {
  size(500, 500 );
  for (int i = 0; i < x; i++) {
    for (int j = 0; j < y; j++) {
      breath[i][j] = new Tile(false, 0);
      breath[i][j].shade = 300;
      if (int(floor(random(5))) == 1) {
        breath[i][j].hot = true;
      }
    }
  }
}

void draw() {
  for (int i = 0; i < x; i++) {
    for (int j = 0; j < x; j++) {
      fill(breath[i][j].shade);
      rect(i*20, j*20, 20, 20);
    }
  }
  textSize(20);
  fill(0);
}


void mousePressed() {
  for (int i = 0; i < 50; i++) {
    for (int j = 0; j < 50; j++) {
      if (mouseX > i*20 && mouseX < i*20+20 && mouseY > j*20 && mouseY < j*20+20 && breath[i][j].hot) {
        breath[i][j].shade = 10;
      }
    }
  }
}
