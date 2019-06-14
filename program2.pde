// Java variables
import java.io.FileWriter;
import java.io.*;
FileWriter fw;
BufferedWriter bw;
// program variables
Boolean run = true;
Boolean start = true;
Boolean start2 = true;
String stage = "START";
int x = 25;
int y = 25;
int count = 0;
int z = 0;
int screen = 0;
int x2 = 50;
int x1 = 10;
int score = 0;
int numberOfClicks = 0;
int n = 1;
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
  // clear removes the previous screen
  fill(255, 255, 255);
  rect(0, 0, 500, 500);
}

void startScreen() {
  // start screen function
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
  // help screen function
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
  // game over screen function
  clear();
  fill(0, 0, 0); 
  textSize(18);
  text("Game Over!", 180, 50);
  text("<-- Highest number of tiles cleared history\nRestart program to restart", 60, 75);
  String[] lines = loadStrings("database.txt");



  println("there are " + lines.length + " lines");
  for (int i = 0; i < lines.length-1; i++) {
    n++;
    fill(0, 0, 0);
    sorter(lines);
    remover(int(lines), lines.length);
    text(lines[i], 20, i*20);
  }
}

int remover(int arr[], int n) {  
  int[] temp = new int[n];  
  int j = 0;  
  for (int i=0; i<n-1; i++) {  
    if (arr[i] != arr[i+1]) {  
      temp[j++] = arr[i];
    }
  }  
  temp[j++] = arr[n-1];     
  // Changing original array  
  for (int i=0; i<j; i++) {  
    arr[i] = temp[i];
  }  
  return j;
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

void breakBoard() {
  // breakBoard is the first step to starting the game
  // it "break" a section of the map
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

void sorter(String arr[]) { 
  int n = arr.length; 
  for (int i = 0; i < n-1; i++) 
    for (int j = 0; j < n-i-1; j++) 
      if (int(arr[j]) > int(arr[j+1])) 
      { 
        // swap arr[j+1] and arr[i] 
        int temp = int(arr[j]); 
        arr[j] = arr[j+1]; 
        arr[j+1] = str(temp);
      }
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






  if (mouseButton == RIGHT) {
    breakBoard();
  }

  if (stage == "GAME" && numberOfClicks != 1 && numberOfClicks !=2 ) {
    for (int i = 0; i < 25; i++) {
      for (int j = 0; j < 25; j++) {
        if (mouseButton == LEFT && mouseX > i*20 && mouseX < i*20+20 && mouseY > j*20 && mouseY < j*20+20 && board[i][j].hot && stage == "GAME") {
          board[i][j].shade = 10;
          stage = "OVER";
        }
        if (mouseButton == LEFT && mouseX > i*20 && mouseX < i*20+20 && mouseY > j*20 && mouseY < j*20+20 && !board[i][j].hot && !board[i][j].broken && !(stage == "HELP")) {
          board[i][j].shade = 255;
          board[i][j].isClicked = true;
          score++;
          try {
            PrintWriter out = new PrintWriter(new BufferedWriter(new FileWriter("./database.txt", true))); // true = append 
            // need admin privs to access dtabase.txt apparently

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
