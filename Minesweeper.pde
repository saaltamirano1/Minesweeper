private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> mine; //ArrayList of just the minesweeper buttons that are mined
int rows = 20;
int columns = 20;
boolean isLost = false;
int countBlob = 0;
void setup ()
{
    size(400, 400);
    textAlign(CENTER,CENTER);
   
    // make the manager

    buttons = new MSButton [rows] [columns];
    mine = new ArrayList <MSButton>();
    //your code to declare and initialize buttons goes here
    for(int i = 0;i<columns;i++)
    {
        for(int j = 0; j < rows;j++){
            buttons[j][i]= new MSButton(j,i);
    }
}
   
   
    setMines();
}
public void setMines()
{  for (int i = 0; i < 40; i++) {
    final int r1 = (int)(Math.random()*20);
    final int r2 = (int)(Math.random()*20);
    if ((mine.contains (buttons[r1][r2])) == false) {
      mine.add(buttons[r1][r2]);
    }
    else {i +=-1;}
}
}

public void draw ()
{
    background( 0 );
    if(isWon())
        displayWinningMessage();
       
        //new
    for (int i = 0; i < rows; i++) {
     for (int j = 0; j < columns; j++) {
        buttons[i][j].draw();
      }
    }
    //end
   
}
public boolean isWon()
{  
 
  return false;
}
public void displayLosingMessage()
{  
   
    for(int i=0;i<mine.size();i++)
        if(mine.get(i).isClicked()==false)
            mine.get(i).mousePressed();
    isLost = true;
    buttons[rows/2][(columns/2)-4].setLabel("Y");
    buttons[rows/2][(columns/2)-3].setLabel("O");
    buttons[rows/2][(columns/2-2)].setLabel("U");
    buttons[rows/2][(columns/2-1)].setLabel("");
    buttons[rows/2][(columns/2)].setLabel("L");
    buttons[rows/2][(columns/2+1)].setLabel("O");
    buttons[rows/2][(columns/2+2)].setLabel("S");
    buttons[rows/2][(columns/2+3)].setLabel("E");
}
public void displayWinningMessage()
{
    isLost = true;
    buttons[rows/2][(columns/2)-4].setLabel("Y");
    buttons[rows/2][(columns/2)-3].setLabel("O");
    buttons[rows/2][(columns/2-2)].setLabel("U");
    buttons[rows/2][(columns/2-1)].setLabel("");
    buttons[rows/2][(columns/2)].setLabel("W");
    buttons[rows/2][(columns/2+1)].setLabel("I");
    buttons[rows/2][(columns/2+2)].setLabel("N");
    buttons[rows/2][(columns/2+3)].setLabel("!");
}

//new
public void mousePressed (){
  int mX = mouseX;
  int mY = mouseY;
  buttons[(int)(mY/20)][(int)(mX/20)].mousePressed();
}
//end

public class MSButton
{
    private int r, c;
    private float x,y, width, height;
    private boolean clicked, marked;
    private String label;
   
    public MSButton ( int rr, int cc )
    {
         width = 400/columns;
         height = 400/rows;
        r = rr;
        c = cc;
        x = c*width;
        y = r*height;
        label = "";
        marked = clicked = false;

    }
    public boolean isMarked()
    {
        return marked;
    }
    public boolean isClicked()
    {
        return clicked;
    }
    // called by manager
   
    public void mousePressed ()
    {
      if (isLost == false) {
        if (mouseButton == RIGHT && buttons[r][c].isClicked()) {
         
        }
        else if (mouseButton == RIGHT) {
          marked = !marked;
        }
        else if (marked == true) {}
        else if (mine.contains(this)) {
          clicked = true;
          displayLosingMessage();
        }
        else if (countMines(r,c) > 0) {
          label = ""+countMines(r,c);
          if (!clicked) {countBlob+=1;}
          if (countBlob == 400-mine.size()) {displayWinningMessage();}
          clicked = true;
        }
        else {

         
          if (!clicked) {countBlob+=1;}
          if (countBlob == 400-mine.size()) {displayWinningMessage();}
          clicked = true;
         
          if(isValid(r-1,c-1) && !buttons[r-1][c-1].isClicked()) {
          buttons[r-1][c-1].mousePressed();}
          if(isValid(r-1,c) && !buttons[r-1][c].isClicked()) {
          buttons[r-1][c].mousePressed();}
          if(isValid(r-1,c+1) && !buttons[r-1][c+1].isClicked()){
          buttons[r-1][c+1].mousePressed();}
         
          if(isValid(r,c-1) && !buttons[r][c-1].isClicked()){
          buttons[r][c-1].mousePressed();}
          if(isValid(r,c+1) && !buttons[r][c+1].isClicked()){
          buttons[r][c+1].mousePressed();}
         
          if(isValid(r+1,c-1) && !buttons[r+1][c-1].isClicked()){
          buttons[r+1][c-1].mousePressed();}
          if(isValid(r+1,c) && !buttons[r+1][c].isClicked()){
          buttons[r+1][c].mousePressed();}
          if(isValid(r+1,c+1) && !buttons[r+1][c+1].isClicked()){
          buttons[r+1][c+1].mousePressed();}
        }
      }
    }

    public void draw ()
    {    
      if (marked)
            fill(0);
         
         else if( !marked && clicked && mine.contains(this) )
             fill(255,0,0);
         else if( marked && mine.contains(this) )
             fill(100);
         else if( !marked && clicked && !mine.contains(this) )
             fill(50,200,100);
             
        else if(clicked)
            fill(0,200,100 );
        else
            fill( 100 );

        rect(x, y, width, height);
        fill(0);
        text(label,x+width/2,y+height/2);
    }
    public void setLabel(String newLabel)
    {
        label = newLabel;
    }
    public boolean isValid(int r, int c)
    {
        if (r <rows && r >= 0 && c < columns && c >= 0) {return true;}
        return false;
    }
    public int countMines(int row, int col)
    {
        int numMines = 0;
        if (isValid(row-1,col) == true && mine.contains(buttons[row-1][col]))
        {
            numMines++;
        }
        if (isValid(row+1,col) == true && mine.contains(buttons[row+1][col]))
        {
            numMines++;
        }
         if (isValid(row,col-1) == true && mine.contains(buttons[row][col-1]))
        {
            numMines++;
        }
         if (isValid(row,col+1) == true && mine.contains(buttons[row][col+1]))
        {
            numMines++;
        }
         if (isValid(row-1,col+1) == true && mine.contains(buttons[row-1][col+1]))
        {
            numMines++;
        }
         if (isValid(row-1,col-1) == true && mine.contains(buttons[row-1][col-1]))
        {
            numMines++;
        }
         if (isValid(row+1,col+1) == true && mine.contains(buttons[row+1][col+1]))
        {
            numMines++;
        }
         if (isValid(row+1,col-1) == true && mine.contains(buttons[row+1][col-1]))
        {
            numMines++;
        }
        return numMines;
    }
}
