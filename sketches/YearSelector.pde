YearButton[] buttons; // define the buttons array

int yearSelectorX;
int yearSelectorY;
int buttonBarWidth;

void setupYearSelector(int xPosition, int yPosition, int[] years){
  yearSelectorX = xPosition;
  yearSelectorY = yPosition;
  
  buttons = new YearButton[count]; // we'll create a button for every year
  
  for (int row = 0; row < count; row++) {
    int buttonSpacing = 52;
    buttons[row] = new YearButton(xPosition + (row * buttonSpacing), yPosition, years[row], row);
  }
  buttonBarWidth = 16 * 52 + 50;
}


void drawYearSelector() {
  fill(#5a6872);
  rect(0, yearSelectorY - 10, width, 50);
  
  for (YearButton button : buttons) {
    button.display();
  }
} 

class YearButton {
  int x, y; // The x- and y-coordinates
  int width = 50; // Dimension (height)
  int height = 30; // Dimension (height)
  int curve = 4; // border radius
  
  color baseColor = uiColor5; // Default color
  color activeColor = uiColor4; // Color for active button
  color buttonTextColor = #ffffff;
  
  boolean over = false; // True when the mouse is over
  boolean pressed = false; // True when the mouse is over and pressed
  
  int year;
  int index;
  
  // Constructor
  YearButton(int x, int y, int year, int index) {
    this.x = x;
    this.y = y;
    this.year = year;
    this.index = index;
  }
 
  boolean press() {
    if (over == true) {
      pressed = true;
      return true;
    } else {
      return false;
    }
  }
 
  void release() {
    pressed = false; // Set to false when the mouse is released
  }
  // Custom method for drawing the buttons
  void display() {
      
    if ((mouseX >= x) && (mouseX <= x + width) && (mouseY >= y) && (mouseY <= y + height)) {
      over = true;
    } else {
      over = false;
    }
    
    if(index == selectedYearIndex || over == true){
      fill(activeColor);
    } else {
      fill(baseColor);
    }
    stroke(baseColor);
    rect(x, y, width, height, curve);
    textSize(12);
    textAlign(CENTER);
    fill(buttonTextColor);
    text(year, x+width/2, y+20);
  }
}

void keyPressed() {
  if (key == CODED) {
    if (keyCode == RIGHT) {
      if(selectedYearIndex < count - 1){
        selectedYearIndex += 1;
      }
    } else if (keyCode == LEFT) {
      if(selectedYearIndex > 0) {
        selectedYearIndex -= 1;
      }
    } 
  } 
}

void mousePressed() {
    for (YearButton but : buttons) {
      but.press();
      if (but.pressed) {
        selectedYearIndex = but.index;
        break; // Other buttons won't be pressed, just stop
      } 
    }
}

void mouseReleased() {
  for (YearButton but : buttons) {
    but.release();
  }
  loop();
}
  
void mouseMoved() {
  if(mouseY > yearSelectorY + 10 && mouseY < yearSelectorY + 40 && mouseX > yearSelectorX && mouseX < yearSelectorX + buttonBarWidth ) {
    cursor(HAND);
  } else {
    cursor(ARROW);
  }
  
}
