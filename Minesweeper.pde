import de.bezier.guido.*;
final int NUM_ROWS = 10;
final int NUM_COLS = 10;
final int NUM_MINES = 5;
private MSButton[][] buttons = new MSButton [NUM_ROWS][NUM_COLS]; //2d array of minesweeper buttons
private ArrayList <MSButton> mines = new ArrayList (NUM_ROWS); //ArrayList of just the minesweeper buttons that are mined

public void setup () {
  size(400, 400);
  textAlign(CENTER, CENTER);

  // make the manager
  Interactive.make(this);
  for (int r = 0; r < NUM_ROWS; r++)
    for (int c = 0; c < NUM_COLS; c++)
      buttons[r][c] = new MSButton(r, c);
  setMines();
}
public void setMines() {
  int r = 0;
  int c = 0;
  for (int i = 0; i < NUM_MINES; i++) {
    r = (int)(Math.random()*NUM_ROWS);
    c = (int)(Math.random()*NUM_COLS);
    MSButton newMine = new MSButton(r, c);
    mines.add(newMine);
    System.out.println("(" + c + ", " + r + ")");
  }
}
public void draw () {
  background(0);
  if (isWon() == true)
    displayWinningMessage();
}
public boolean isWon() {
  //your code here
  return false;
}
public void displayLosingMessage() {
    rect(20, 20, 400/NUM_COLS, 400/NUM_ROWS);
    fill(255);
    text("you suck", 400/NUM_COLS, 400/NUM_ROWS);
}
public void displayWinningMessage() {
  //your code here
}
public boolean isValid(int r, int c) {
  return(r >= 0 && c >= 0 && r < NUM_ROWS && c < NUM_COLS);
}
public int countMines(int row, int col) {
  int numMines = 0;
  for(int r = row-1; r < row+1; r++)
    for(int c = col-1; c < col+1; c++)
        if(isValid(r, c) && mines.contains(buttons[r][c]))
          numMines++;
  return numMines;
}
public class MSButton {
  private int myRow, myCol;
  private float x, y, width, height;
  private boolean clicked, flagged;
  private String myLabel;

  public MSButton (int row, int col) {
    width = 400/NUM_COLS;
    height = 400/NUM_ROWS;
    myRow = row;
    myCol = col; 
    x = myCol*width;
    y = myRow*height;
    myLabel = "";
    flagged = clicked = false;
    Interactive.add( this ); // register it with the manager
  }

  // called by manager
  public void mousePressed () {
    clicked = true;
    if(mouseButton == RIGHT)
      flagged = true;
    if(mines.contains(this)){
      displayLosingMessage();
      for(int r = 0; r <= NUM_ROWS; r++)
        for(int c = 0; c <= NUM_COLS; c++)
          if(isValid(r, c))
            if(!(mines.contains(buttons[r][c])) && buttons[r][c].clicked == false && buttons[r][c].flagged == false)
              buttons[r][c].mousePressed(); 
    }
    if(countMines(myRow, myCol) > 0 && flagged == false)
       setLabel(countMines(myRow,myCol));
        
  }
  public void draw () {    
    if (flagged)
      fill(0);
    else if ( clicked && mines.contains(this) ) 
      fill(255, 0, 0);
    else if (clicked)
      fill(200);
    else 
    fill(100);

    rect(x, y, width, height);
    fill(0);
    text(myLabel, x+width/2, y+height/2);
  }
  public void setLabel(String newLabel) {
    myLabel = newLabel;
  }
  public void setLabel(int newLabel) {
    myLabel = ""+ newLabel;
  }
  public boolean isFlagged() {
    return flagged;
  }
}
