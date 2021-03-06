import de.bezier.guido.*;
int NUM_ROWS = 10;
int NUM_COLS = 10;
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> mines = new ArrayList <MSButton>(); //ArrayList of just the minesweeper buttons that are mined

void setup ()
{
    size(400, 400);
    textAlign(CENTER,CENTER);
    textSize(24);
    
    // make the manager
    Interactive.make( this );
    
    buttons = new MSButton[20][20];
    for(int r = 0; r < buttons.length; r++){
      for(int c = 0; c < buttons[r].length; c++){
        buttons[r][c] = new MSButton(r,c);
      }
    }
    
    
    setMines();
}
public void setMines()
{
    int row, col;
    int numMines = (int)(Math.random()*5)+5;
    
    for(int i = 0; i < numMines; i++){
      row = (int)(Math.random()*NUM_ROWS+1);
      col = (int)(Math.random()*NUM_COLS+1);
      if(!(mines.contains(buttons[row][col]))){
        mines.add(buttons[row][col]);
      }
    }

}

public void draw ()
{
    background( 0 );
    if(isWon() == true)
        displayWinningMessage();
}
public boolean isWon()
{
    for(int r = 0; r < buttons.length; r++){
      for(int c = 0; c < buttons[r].length; c++){
        if(buttons[r][c].clicked == true && !mines.contains(buttons[r][c])){
          return true;
        }
      }
    }
    
    return false;
}
public void displayLosingMessage()
{
    text("You won!", 200,200);
}
public void displayWinningMessage()
{
    text("You Lost!", 200, 200);
}
public boolean isValid(int r, int c)
{

    if(r > 0 && r <= NUM_ROWS){
      return true;
    }
    
    if(c > 0 && c <= NUM_COLS){
      return true;
    }
  
    return false;
}
public int countMines(int row, int col)
{
    int numMines = 0;
    
    //row above
    if(isValid(row-1, col-1)){
      if(mines.contains(buttons[row-1][col-1])){
        numMines++;
      }
    }
    
    if(isValid(row-1, col)){
      if(mines.contains(buttons[row-1][col])){
        numMines++;
      }
    }
    
    if(isValid(row-1, col+1)){
      if(mines.contains(buttons[row-1][col+1])){
        numMines++;
      }
    }
    
    //this row
    if(isValid(row, col-1)){
      if(mines.contains(buttons[row][col-1])){
        numMines++;
      }
    }
    
    if(isValid(row, col+1)){
      if(mines.contains(buttons[row][col+1])){
        numMines++;
      }
    }
    
    //row below
    if(isValid(row+1, col-1)){
      if(mines.contains(buttons[row+1][col-1])){
        numMines++;
      }
    }
    
    if(isValid(row+1, col)){
      if(mines.contains(buttons[row+1][col])){
        numMines++;
      }
    }
    
    if(isValid(row+1, col+1)){
      if(mines.contains(buttons[row+1][col+1])){
        numMines++;
      }
    }
    
    return numMines;
}
public class MSButton
{
    private int myRow, myCol;
    private float x,y, width, height;
    private boolean clicked, flagged;
    private String myLabel;
    
    public MSButton ( int row, int col )
    {
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
    public void mousePressed () 
    {
        clicked = true;
        if (mouseButton == RIGHT){
          
          if(flagged == true){
            flagged = false;
          }
          
          if(flagged == false){
            flagged = true;
            clicked = false;
          }
         
        }else if (mines.contains(this)){
          displayLosingMessage();
        }else if(countMines(myRow,myCol) > 0){
          setLabel(countMines(myRow,myCol));
        }else{
          
          if(isValid(myRow-1, myCol-1) == true && buttons[myRow-1][myCol-1].clicked == false){
            buttons[myRow-1][myCol-1].mousePressed();
          }
          
          if(isValid(myRow-1, myCol) == true && buttons[myRow-1][myCol].clicked == false){
            buttons[myRow-1][myCol].mousePressed();
          }
          
          if(isValid(myRow-1, myCol+1) == true && buttons[myRow-1][myCol+1].clicked == false){
            buttons[myRow-1][myCol+1].mousePressed();
          }
          
          if(isValid(myRow, myCol-1) == true && buttons[myRow][myCol-1].clicked == false){
            buttons[myRow][myCol-1].mousePressed();
          }
          
          if(isValid(myRow, myCol+1) == true && buttons[myRow][myCol+1].clicked == false){
            buttons[myRow][myCol+1].mousePressed();
          }
         
         if(isValid(myRow+1, myCol-1) == true && buttons[myRow+1][myCol-1].clicked == false){
            buttons[myRow+1][myCol-1].mousePressed();
          }
          
          if(isValid(myRow+1, myCol) == true && buttons[myRow+1][myCol].clicked == false){
            buttons[myRow+1][myCol].mousePressed();
          }
          
          if(isValid(myRow+1, myCol+1) == true && buttons[myRow+1][myCol+1].clicked == false){
            buttons[myRow+1][myCol+1].mousePressed();
          }
        }
          
    }
    public void draw () 
    {    
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
    public void setLabel(String newLabel)
    {
        myLabel = newLabel;
    }
    public void setLabel(int newLabel)
    {
        myLabel = ""+ newLabel;
    }
    public boolean isFlagged()
    {
        return flagged;
    }
}
