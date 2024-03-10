import de.bezier.guido.*;
private final static int NUM_ROWS = 20;
private final static int NUM_COLS = 20;
private final static int NUM_MINES = 30;
private MSButton[][] buttons = new MSButton [NUM_ROWS][NUM_COLS]; //2d array of minesweeper buttons
private ArrayList <MSButton> mines = new ArrayList(NUM_MINES); //ArrayList of just the minesweeper buttons that are mined

public void setup () {
  size(400, 400);
  textAlign(CENTER, CENTER);
  Interactive.make(this);
  for (int r = 0; r < NUM_ROWS; r++)
    for (int c = 0; c < NUM_COLS; c++)
      buttons[r][c] = new MSButton(r, c);
  for(int i = 0; i < NUM_MINES; i++)
    setMines();
}

public void setMines() {
  int r = (int)(Math.random()*NUM_ROWS), c = (int)(Math.random()*NUM_COLS);
  if(!mines.contains(buttons[r][c]))
    mines.add(buttons[r][c]);
}

public int countMines(int row, int col) {
  int numMines = 0;
  for(int r = row-1; r < row+2; r++)
    for(int c = col-1; c < col+2; c++)
      if(isValid(r, c) && mines.contains(buttons[r][c]))
          numMines++;
  return numMines;
}

public boolean isValid(int r, int c) {
  return (r >= 0 && c >= 0 && r < NUM_ROWS && c < NUM_COLS);
}

public void draw () {
  background(0);
  if (isWon() == true)
    displayWinningMessage();
}

public boolean isWon() {
  for(int i = 0; i < mines.size(); i++)
    if(mines.get(i).isFlagged() == true)
      return true;
  return false;
}

public void displayLosingMessage() {
  int row = NUM_ROWS/2-1;
  buttons[row][NUM_COLS/2-6].setLabel("Y");
  buttons[row][NUM_COLS/2-5].setLabel("O");
  buttons[row][NUM_COLS/2-4].setLabel("U");
  buttons[row][NUM_COLS/2-2].setLabel("L");
  buttons[row][NUM_COLS/2-1].setLabel("O");
  buttons[row][NUM_COLS/2].setLabel("S");
  buttons[row][NUM_COLS/2+1].setLabel("E");
  buttons[row][NUM_COLS/2+3].setLabel("L");
  buttons[row][NUM_COLS/2+4].setLabel("O");
  buttons[row][NUM_COLS/2+5].setLabel("L");
  buttons[row][NUM_COLS/2+6].setLabel("!");
  for(int i = 0; i < mines.size(); i++)
    if(mines.get(i).clicked == false)
      mines.get(i).mousePressed();
}

public void displayWinningMessage() {
  int row = NUM_ROWS/2-1;
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
    if(mouseButton == RIGHT){
      flagged = !flagged;
      if(flagged == false)
        clicked = false;
    }
    else if(mines.contains(this))
      displayLosingMessage();
    else if(countMines(myRow,myCol) > 0)
      setLabel(countMines(myRow,myCol));
    else {
      for(int r = myRow-1; r < myRow+2; r++)
        for(int c = myCol-1; c < myCol+2; c++)
          if(isValid(r,c) && buttons[r][c].clicked == false)
            buttons[r][c].mousePressed();
    }
  }
  public void draw () { 
    if (flagged)
      fill(0);
    else if (clicked && mines.contains(this)) 
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
