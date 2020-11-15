// SprayCan.pde
// Copyright 2020 Roland Richter

// 540px-David_by_Michelangelo_JBU06.JPG by Jörg Bittner Unna, 
// CC BY 3.0, https://commons.wikimedia.org/w/index.php?curid=38304749
PImage david;

// Radius, color, and opacity of the brush
int brushRadius = 19;
int brushColor = #FD0E35; // Tractor red
int opacity = 24;

// Position of the "Save" button
final int saveButtonX = 510;
final int saveButtonY =  30;

// Positions and colors of three color buttons
// color names as of http://latexcolor.com/
final int firstX = 380;
final int firstY = 30;
final int firstColor  = #FD0E35; // Tractor red

final int secondX = 420;
final int secondY = 30;
final int secondColor = #FFDF00; // Golden yellow

final int thirdX = 460;
final int thirdY = 30;
final int thirdColor  = #645452; // Wenge

boolean hasSelectedColor = false;


void setup() {
    size(540, 720);

    // Draws Michelangelos David as background
    david = loadImage("540px-David_by_Michelangelo_JBU06.JPG");
    background(david);

    // Uses cross cursor to indicate paint tool
    cursor(CROSS);

    // This sketch paints various circles; it makes sense
    // to use their radius, not their extent.
    ellipseMode(RADIUS);
    strokeWeight(2);

    // Draws the Save button as a gray circle ...
    stroke(255);
    fill(64);
    circle(saveButtonX, saveButtonY, brushRadius);

    // ... with a white "S" inside it
    fill(255);
    textSize(26);
    textAlign(CENTER, CENTER);
    text("S", saveButtonX, saveButtonY-3);

    // Draws three color buttons, all with black border
    stroke(0);

    fill(firstColor);
    circle(firstX, firstY, brushRadius);

    fill(secondColor);
    circle(secondX, secondY, brushRadius);

    fill(thirdColor);
    circle(thirdX, thirdY, brushRadius);
}


void mouseClicked() {
    // If the Save button was clicked, saves the current frame
    if (dist(mouseX, mouseY, saveButtonX, saveButtonY) < brushRadius) {
        cursor(WAIT);
        saveFrame("David_####.jpg");
        cursor(CROSS);
    }

    // If one of the color buttons was clicked,
    // selects the brush color accordingly
    if (dist(mouseX, mouseY, firstX, firstY) < brushRadius) {
        brushColor = firstColor;
        hasSelectedColor = true;
    } else if (dist(mouseX, mouseY, secondX, secondY) < brushRadius) {
        brushColor = secondColor;
        hasSelectedColor = true;
    } else if (dist(mouseX, mouseY, thirdX, thirdY) < brushRadius) {
        brushColor = thirdColor;
        hasSelectedColor = true;
    }

    // Re-draws color buttons, with white border
    // around the selected color button
    strokeWeight(2);

    stroke(brushColor == firstColor ? 255 : 0);
    fill(firstColor);
    circle(firstX, firstY, brushRadius);

    stroke(brushColor == secondColor ? 255 : 0);
    fill(secondColor);
    circle(secondX, secondY, brushRadius);

    stroke(brushColor == thirdColor ? 255 : 0);
    fill(thirdColor);
    circle(thirdX, thirdY, brushRadius);
}


void draw() {
    noStroke();

    // Paints onto background image
    if (mousePressed && hasSelectedColor) {
        // Prevents buttons to get painted on
        if (!(mouseX >= 340 && mouseY <= 70)) {
            fill(brushColor, opacity);
            circle(mouseX, mouseY, brushRadius);
        }
    }
}
