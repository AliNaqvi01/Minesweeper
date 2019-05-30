int x = 25;
int y = 25;
int count = 0;
Tile breath[][] = new Tile [x][y];

class Tile {
  boolean hot;
  int shade;
  int count;
  
  Tile(boolean h, int s, int t) {
    this.hot = h;
    this.shade = s;
    this.count = t;
  }
}


void setup() {
  size(500, 500 );
  for (int i = 0; i < x; i++) {
    for (int j = 0; j < y; j++) {
      breath[i][j] = new Tile(false, 0, 0);
      breath[i][j].shade = 300;
      if (int(floor(random(5))) == 1) {
        breath[i][j].hot = true;
      }
    }
  }
    for(int i = 1; i < 24; i++){
    for(int j = 1; j < 24; j++){
      if(breath[i+1][j].hot){
       breath[i][j].count++;    
      }
            if(breath[i-1][j].hot){
       breath[i][j].count++;    
      }
            if(breath[i][j-1].hot){
       breath[i][j].count++;    
      }
            if(breath[i][j+1].hot){
       breath[i][j].count++;    
      }
            if(breath[i-1][j+1].hot){
       breath[i][j].count++;    
      }
            if(breath[i-1][j-1].hot){
       breath[i][j].count++;    
      }
       if(breath[i+1][j+1].hot){
       breath[i][j].count++;    
      }
       if(breath[i+1][j-1].hot){
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
    }
  }
  textSize(20);
  fill(0);
  
  text(breath[7][5].count,100,100);
  

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
