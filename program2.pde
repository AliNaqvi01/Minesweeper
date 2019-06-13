int x = 25;
import java.io.FileWriter;
import java.io.*;
int y = 25;
int count = 0;
int z = 0;
Boolean run = true;
Boolean start = true;
Boolean start2 = true;
int screen = 0;
int x2 = 50;
int x1 = 10;
String stage = "START";
int score = 0;
int numberOfClicks = 0;
FileWriter fw;
BufferedWriter bw;
ArrayList<Integer> scores = new ArrayList<Integer>();


Tile board[][] = new Tile [x][y];

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
void clear() {
  fill(255, 255, 255);
  rect(0, 0, 500, 500);
}

void startScreen() {

  fill(255, 0, 255);
  rect(0, 0, 500, 500);
  fill(255, 255, 255);
  rect(100, 240, 100, 30);
  fill(0, 0, 0);
  textSize(14);
  text("START", 130, 260);
  fill(255, 255, 255);
  rect(300, 240, 100, 30);
  fill(0, 0, 0);
  text("HELP", 335, 260);  
  textSize(45);
  text("MINESWEEPER", 100, 150);
}

void helpScreen() {

  clear();
  fill(0, 0, 0); 
  textSize(18);
  text("A simple Minsweeper clone", 125, 50);
  text("Right click the anywhere to break the board.\nThis will show the adjacent mines in the square.\nUse the information to click on tiles without mines.\nClicking on a mine will cause the game to restart.\nOnce you have cleared all mines, you win", 30, 130);
  rect(200, 300, 100, 50);
  fill(255, 255, 255);
  text("Start", 210, 320);
}

void gameOver() {
  clear();
  fill(0, 0, 0); 
  textSize(18);
  text("Game Over!", 125, 50);
  String[] lines = loadStrings("data/database.txt");
  println("there are " + lines.length + " lines");
  for (int i = 0; i < lines.length; i++) {
    fill(0,0,0);
    text(lines[i], 125, i*20);
  }
}

void showNumber() {
  // showNumber shows the count of adjacent mines on each tile
  for (int i = 0; i < 25; i++) {
    for (int j = 0; j < 25; j++) {
      if (board[i][j].isClicked && !(board[i][j].broken)) {
        fill(255, 0, 255);
        text(board[i][j].count, i*20, j*20+20);
      }
      if (board[i][j].broken && i > 0 && j > 0 && i < 24 &&   j < 24 && ((board[i][j-1].broken == false)|| (board[i][j+1].broken == false) ||( board[i+1][j].broken == false )||( board[i-1][j].broken == false))) {
        fill(255, 255, 255);
        text(board[i][j].count, i*20, j*20+20);
      }
      if (i == 0 && board[i][j].broken) {
        fill(255, 255, 255);
        text(board[i+1][j].count, i*20, j*20+20);
      }
      if (j == 0 && board[i][j].broken) {
        fill(255, 255, 255);
        text(board[i][j+1].count, i*20, j*20+20);
      }
      if (i == 24 && board[i][j].broken) {
        fill(255, 255, 255);
        text(board[i-1][j].count, i*20, j*20+20);
      }
      if (j == 24 && board[i][j].broken) {
        fill(255, 255, 255);
        text(board[i][j-1].count, i*20, j*20+20);
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
                board[i+k][j].shade = 0;
                board[i+k][j+l].shade = 0;
                board[i+k][j].broken = true;
                board[i+k][j+l].broken = true;
              }
            }
          }
        }
      }
    }
  }
}

void sort() {
  int n = scores.size();
  for (int i = 0; i < n-1; i++)
    for (int j = 0; j < n-i-1; j++)
      if (scores.get(j) > scores.get(j+1))
      {
        // swap temp and arr[i]
        int temp = scores.get(j);
        scores.set(j, scores.get(j+1));
        scores.set(j+1, temp);
      }
  print(scores);
}

void setup() {




  for (int i = 0; i < 20; i++) {
    scores.add(int(random(20)));
  }

  size(500, 500);
  for (int i = 0; i < x; i++) {
    for (int j = 0; j < y; j++) {
      board[i][j] = new Tile(false, 0, 0, false);
      board[i][j].shade = 300;
      board[i][j].isClicked = false;
      // makes every 1 in 5 blocks on random to be mines
      if (int(floor(random(2))) == 1) {
        board[i][j].hot = true;
      } else {
        board[i][j].hot = false;
      }
    }
  }
  for (int i = 1; i < 24; i++) {
    for (int j = 1; j < 24; j++) {

      if (board[i+1][j].hot) {
        board[i][j].count++;
      }
      if (board[i-1][j].hot) {
        board[i][j].count++;
      }
      if (board[i][j-1].hot) {
        board[i][j].count++;
      }
      if (board[i][j+1].hot) {
        board[i][j].count++;
      }
      if (board[i-1][j+1].hot) {
        board[i][j].count++;
      }
      if (board[i-1][j-1].hot) {
        board[i][j].count++;
      }
      if (board[i+1][j+1].hot) {
        board[i][j].count++;
      }
      if (board[i+1][j-1].hot) {
        board[i][j].count++;
      }
    }
  }

  print(scores);

  int length = scores.size();  


  String[] list = new String[length];

  for (int i = 0; i < length; i++) {
    list[i] = str(scores.get(i));
  }
}

void draw() {

  if (stage == "START") {
    startScreen();
  } else if (stage == "OVER") {
    gameOver();
  } else if (stage == "HELP") {
    clear();
    helpScreen();
  } else if (stage == "GAME") {

    clear();

    for (int i = 0; i < x; i++) {
      for (int j = 0; j < x; j++) {
        fill(board[i][j].shade);
        rect(i*20, j*20, 20, 20);
        fill(178, 34, 34);
      }
    }

    textSize(14);
    showNumber();
  }
}


void mousePressed() {

  if (mouseX > 100 && mouseX < 200 && mouseY > 240 && mouseY < 270) {
    stage = "GAME";
  }
  if (mouseX > 300 && mouseX < 400 && mouseY > 240 && mouseY < 270 && !(stage == "GAME")) {
    stage = "HELP";
  }


  if (mouseX > 200 && mouseX < 300 && mouseY > 300 && mouseY < 350 && stage == "HELP") {
    stage = "GAME";
  }

  numberOfClicks++;
  sort();







  if (mouseButton == RIGHT) {
    breakBoard();
  }

  if (stage == "GAME" && numberOfClicks >= 2) {
    for (int i = 0; i < 25; i++) {
      for (int j = 0; j < 25; j++) {
        if (mouseButton == LEFT && mouseX > i*20 && mouseX < i*20+20 && mouseY > j*20 && mouseY < j*20+20 && board[i][j].hot ) {
          board[i][j].shade = 10;
          stage = "OVER";
        }
        if (mouseButton == LEFT && mouseX > i*20 && mouseX < i*20+20 && mouseY > j*20 && mouseY < j*20+20 && !board[i][j].hot && !board[i][j].broken) {
          board[i][j].shade = 255;
          board[i][j].isClicked = true;
          score++;
          try {
            PrintWriter out = new PrintWriter(new BufferedWriter(new FileWriter("C:/users/ali/desktop/program2/data/database.txt", true))); // true = append

            if (!(score == 0)) {
              out.println(score);

              out.close();
            }
          } 
          catch (IOException e) {
            print(e);
          }
        }
      }
    }
  }
}
