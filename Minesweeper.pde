import de.bezier.guido.*;
//Declare and initialize constants NUM_ROWS and NUM_COLS = 20
int NUM_ROWS = 20;
int NUM_COLS = 20;
int NUM_MINES = 35;
boolean isLost = false;
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> mines; //ArrayList of just the minesweeper buttons that are mined

MSButton but;

void setup ()
{
  size(400, 400);
  textAlign(CENTER, CENTER);
  textSize(18);

  // make the manager
  Interactive.make( this );

  //your code to initialize buttons goes here
  buttons = new MSButton[NUM_ROWS][NUM_COLS];
  mines = new ArrayList <MSButton>();
  for (int i = 0; i < NUM_ROWS; i++) {
    for (int y = 0; y < NUM_COLS; y++) {
      buttons[i][y] = new MSButton(i, y);
    }
  }

  setMines();
}
public void setMines()
{
  //your code
  for (int i = 0; i < NUM_MINES; i++) {
    int rRow = (int)(Math.random()*NUM_ROWS);
    int rCol = (int)(Math.random()*NUM_COLS);
    System.out.println(rRow + " " + rCol);
    if (!mines.contains(buttons[rRow][rCol])) {
      mines.add(buttons[rRow][rCol]);
    } else {
      System.out.println("Button already in array | " + mines);
      i=i-1;
    }
  }
}

public void draw ()
{
  background( 10 );
  if (isWon() == true)
    displayWinningMessage();

  for (int i = 0; i < NUM_COLS; i++) {
    for (int y = 0; y < NUM_ROWS; y++) {
      buttons[i][y].draw();
    }
  }
}
public boolean isWon()
{
  for (int i = 0; i < NUM_ROWS; i++) {
    for (int y = 0; y < NUM_COLS; y++) {
      if (!mines.contains(buttons[i][y]) && buttons[i][y].clicked == false) {
        return false;
      }
    }
  }
  return true;
}
public void displayLosingMessage()
{
  //your code here
  for (int i = 0; i < NUM_ROWS; i++) {
    for (int y = 0; y < NUM_COLS; y++) {
      buttons[i][y].setColor(100, 100, 100);
    }
  }
  for (int i = 0; i < mines.size(); i++) {
    mines.get(i).mineClicked = true;
  }
  for (int i = 0; i < NUM_COLS; i++) {
    buttons[NUM_ROWS/2-2][i].lossColor = true;
    buttons[NUM_ROWS/2-1][i].lossColor = true;
    buttons[NUM_ROWS/2][i].lossColor = true;
    buttons[NUM_ROWS/2+1][i].lossColor = true;
    buttons[NUM_ROWS/2+2][i].lossColor = true;
    buttons[NUM_ROWS/2-2][i].setLabel("L");
    buttons[NUM_ROWS/2-1][i].setLabel("O");
    buttons[NUM_ROWS/2][i].setLabel("S");
    buttons[NUM_ROWS/2+1][i].setLabel("E");
    buttons[NUM_ROWS/2+2][i].setLabel("R");
  }
}
public void displayWinningMessage()
{
  //your code here
  for (int i = 0; i < NUM_ROWS; i++) {
    for (int y = 0; y < NUM_COLS; y++) {
      buttons[i][y].setColor(100, 100, 100);
    }
  }
  for (int i = 0; i < mines.size(); i++) {
    mines.get(i).mineClicked = true;
  }
  for (int i = 0; i < NUM_ROWS; i++) {    
    buttons[i][NUM_COLS/2-3].wonColor = true;
    buttons[i][NUM_COLS/2-2].wonColor = true;
    buttons[i][NUM_COLS/2-1].wonColor = true;
    buttons[i][NUM_COLS/2].wonColor = true;
    buttons[i][NUM_COLS/2+1].wonColor = true;
    buttons[i][NUM_COLS/2+2].wonColor = true;
    buttons[i][NUM_COLS/2-3].setLabel("W");
    buttons[i][NUM_COLS/2-2].setLabel("I");
    buttons[i][NUM_COLS/2-1].setLabel("N");
    buttons[i][NUM_COLS/2].setLabel("N");
    buttons[i][NUM_COLS/2+1].setLabel("E");
    buttons[i][NUM_COLS/2+2].setLabel("R");
  }
}
public boolean isValid(int r, int c)
{
  return (r < NUM_ROWS && c < NUM_COLS && r >= 0 && c >= 0);
}
public int countMines(int row, int col)
{
  int numMines = 0;
  //your code here
  if (isValid(row-1, col-1) && mines.contains(buttons[row-1][col-1])) {
    numMines++;
  }
  if (isValid(row-1, col) && mines.contains(buttons[row-1][col])) {
    numMines++;
  } 
  if (isValid(row-1, col+1) && mines.contains(buttons[row-1][col+1])) {
    numMines++;
  } 
  if (isValid(row, col-1) && mines.contains(buttons[row][col-1])) {
    numMines++;
  } 
  if (isValid(row, col+1) && mines.contains(buttons[row][col+1])) {
    numMines++;
  } 
  if (isValid(row+1, col-1) && mines.contains(buttons[row+1][col-1])) {
    numMines++;
  } 
  if (isValid(row+1, col) && mines.contains(buttons[row+1][col])) {
    numMines++;
  } 
  if (isValid(row+1, col+1) && mines.contains(buttons[row+1][col+1])) {
    numMines++;
  }
  return numMines;
}
public class MSButton
{
  private int myRow, myCol;
  private float x, y, width, height;
  private boolean clicked, flagged, lossColor, wonColor, mineClicked;
  private String myLabel;
  private color myColor;

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
    myColor = color(100, 100, 100);
    Interactive.add( this ); // register it with the manager
  }

  // called by manager
  public void mousePressed () 
  {
    if (!isWon() && !isLost) {
      clicked = true;
      //your code here
      if (mouseButton == 39) {
        if (!flagged) {
          flagged = true;
        } else {
          flagged = false;
          clicked = false;
        }
      } else if (mines.contains(this)) {
        displayLosingMessage();
        isLost = true;
      } else if (countMines(this.myRow, this.myCol) > 0) {
        this.setLabel(countMines(this.myRow, this.myCol));
      } else {
        if (isValid(myRow-1, myCol-1) && !buttons[myRow-1][myCol-1].clicked) 
          buttons[myRow-1][myCol-1].mousePressed();
        if (isValid(myRow-1, myCol) && !buttons[myRow-1][myCol].clicked) 
          buttons[myRow-1][myCol].mousePressed();
        if (isValid(myRow-1, myCol+1) && !buttons[myRow-1][myCol+1].clicked) 
          buttons[myRow-1][myCol+1].mousePressed();
        if (isValid(myRow, myCol-1) && !buttons[myRow][myCol-1].clicked) 
          buttons[myRow][myCol-1].mousePressed();
        if (isValid(myRow, myCol+1) && !buttons[myRow][myCol+1].clicked) 
          buttons[myRow][myCol+1].mousePressed();
        if (isValid(myRow+1, myCol-1) && !buttons[myRow+1][myCol-1].clicked) 
          buttons[myRow+1][myCol-1].mousePressed();
        if (isValid(myRow+1, myCol) && !buttons[myRow+1][myCol].clicked) 
          buttons[myRow+1][myCol].mousePressed();
        if (isValid(myRow+1, myCol+1) && !buttons[myRow+1][myCol+1].clicked) 
          buttons[myRow+1][myCol+1].mousePressed();
      }
    }
  }
  public void draw () 
  {  
    if (lossColor)
      fill(255, 91, 91);
    else if (wonColor)
      fill(94, 106, 210);
    else if (mineClicked) 
      fill(255, 0, 0);
    else if (flagged)
      fill(0);
    else if ( clicked && mines.contains(this) ) 
      fill(255, 0, 0);
    else if (clicked)
      fill( 200 );
    else 
    fill( 100 );

    rect(x, y, width, height);
    fill(0);
    if (parseInt(myLabel) == 1) {
      fill(0, 0, 205);
    } else if (parseInt(myLabel) == 2) {
      fill(0, 128, 0);
    } else if (parseInt(myLabel) >= 3) {
      fill(178, 34, 34);
    }
    text(myLabel, x+width/2, y+height/2);
  }
  public void setLabel(String newLabel)
  {
    myLabel = newLabel;
  }
  public void setLabel(int newLabel)
  {
    myLabel = ""+newLabel;
  }
  public boolean isFlagged()
  {
    return flagged;
  }
  public void setColor(int r, int g, int b) {
    myColor = color(r, g, b);
    fill( myColor );
  }
}
