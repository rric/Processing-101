// SprayCan.pde
// Copyright 2020 Roland Richter

// 540px-David_by_Michelangelo_JBU06.JPG by Jörg Bittner Unna, 
// CC BY 3.0, https://commons.wikimedia.org/w/index.php?curid=38304749
PImage david;

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
}


void draw() {
    noStroke();

    // Paints onto background image
    fill(#FD0E35, 24);
    circle(mouseX, mouseY, 19);
}
