import de.bezier.guido.*;
final int NUM_ROWS = 10;
final int NUM_COLS = 10;
final int NUM_MINES = 3;
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
    c = (int)(Math.random()*NUM_ROWS);
    MSButton newMine = new MSButton(r, c);
    mines.add(newMine);
    System.out.println("(" + r + ", " + c + ")");
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
  //your code here
}
public void displayWinningMessage() {
  //your code here
}
public boolean isValid(int r, int c) {
  return(r >= 0 && c >= 0 && r < NUM_ROWS && c < NUM_COLS);
}
public int countMines(int row, int col) {
  int numMines = 0;
  for(int r = row-1; r < 2; r++)
    for(int c = col-1; c < 2; c++)
      for(int i = 0; i < mines.size(); i++)
        if(isValid(r,c) == true && mines.get(i) == (r,c))
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
    //your code here
  }
  public void draw () {    
    if (flagged)
      fill(0);
    else if ( clicked && mines.contains(this) ) 
      fill(255, 0, 0);
    else if (clicked)
      fill( 200 );
    else 
    fill( 100 );

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
