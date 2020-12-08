/* Simple_sunrise.pde
 * Copyright 2020 Roland Richter
 */

void setup() {
    size(500, 400);
    frameRate(30);
    background(#00BFFF); // "Deep sky blue" 
}


void draw() {
    background(#00BFFF); // "Deep sky blue"     
    
    int frameN = frameCount % 300;
    float frameR = float(frameN) / 300.0;
    
    // Computes the x and y position of the sun
    float sunX = lerp(width/4, width/2, frameR);
    float sunY = lerp(height+30, -30, frameR);
    
    // Computes the sun's colour, in between
    // "Orange-red" and "Sunglow"
    color sunCol = lerpColor(#FF4500, #FFCC33, frameR);
    
    // Draws a sun, roughly centered
    noStroke();
    fill(sunCol); 
    circle(sunX, sunY, 50);
    
    // Draws the ocean
    stroke(#004242); // "Warm black"
    fill(#0077BE);   // "Ocean Boat Blue"
    rect(0, 0.9*height, width, 0.1*height);
    
    // Draws a simple cloud
    noStroke();
    fill(#F5F5F5); // "White smoke"
    ellipse(width/2, height/2, 150, 50);
    
    // Displays current frame rate, frame count, etc.
    textSize(12);
    fill(#000000);
    text(frameRate + " fps", 10, 20);
    text(frameCount + " frames drawn so far", 10, 40);
    text(frameN + " of 300 = " + frameR, 10, 60);
}
