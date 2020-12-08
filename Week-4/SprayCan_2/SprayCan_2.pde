/* SprayCan.pde
 * Copyright 2020 Roland Richter
 */

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
}


void mouseClicked() {
    // If the Save button was clicked, saves the current frame
    if (dist(mouseX, mouseY, saveButtonX, saveButtonY) < brushRadius) {
        cursor(WAIT);
        saveFrame("David_####.jpg");
        cursor(CROSS);
    }
}


void draw() {
    noStroke();

    // Paints onto background image
    if (mousePressed) {
        // Prevents buttons to get painted on
        if (!(mouseX >= 340 && mouseY <= 70)) {
            fill(brushColor, opacity);
            circle(mouseX, mouseY, brushRadius);
        }
    }
}
