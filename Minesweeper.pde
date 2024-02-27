import de.bezier.guido.*;
int NUM_ROWS = 5;
int NUM_COLS = 5;
private MSButton[][] buttons = new MSButton [NUM_ROWS][NUM_COLS]; //2d array of minesweeper buttons
private ArrayList <MSButton> mines; //ArrayList of just the minesweeper buttons that are mined

public void setup (){
    size(400, 400);
    textAlign(CENTER,CENTER);
    
    // make the manager
    Interactive.make(this);
    for(int r = 0; r < NUM_ROWS; r++)
      for(int c = 0; c < NUM_COLS; c++)
        buttons[r][c] = new MSButton(r,c);
    setMines();
}
public void setMines(){
  int r = 0;
  int c = 0;
  for(int i = 0; i < 1; i++){
     r += (int)(Math.random()*5);
     c += (int)(Math.random()*5);
  }
  System.out.println("(" + r + ", " + c + ")");  
}
public void draw (){
    background(0);
    if(isWon() == true)
        displayWinningMessage();
}
public boolean isWon(){
    //your code here
    return false;
}
public void displayLosingMessage(){
    //your code here
}
public void displayWinningMessage(){
    //your code here
}
public boolean isValid(int r, int c){
    return(r >= 0 && c >= 0 && r < NUM_ROWS && c < NUM_COLS);
}
public int countMines(int row, int col){
    int numMines = 0;
    return numMines;
}
public class MSButton{
    private int myRow, myCol;
    private float x,y, width, height;
    private boolean clicked, flagged;
    private String myLabel;
    
    public MSButton (int row, int col){
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
    public void mousePressed (){
        clicked = true;
        //your code here
    }
    public void draw (){    
        if (flagged)
            fill(0);
        else if( clicked && mines.contains(this) ) 
        fill(255,0,0);
        else if(clicked)
            fill( 200 );
        else 
            fill( 100 );

        rect(x, y, width, height);
        fill(0);
        text(myLabel,x+width/2,y+height/2);
    }
    public void setLabel(String newLabel){
        myLabel = newLabel;
    }
    public void setLabel(int newLabel){
        myLabel = ""+ newLabel;
    }
    public boolean isFlagged(){
        return flagged;
    }
}
