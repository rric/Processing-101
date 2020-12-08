/* Jittering_sun.pde
 * Copyright 2020 Roland Richter
 */

// setup() is called only once, at start-up
void setup() {
    size(500, 400);
    // frameRate(60);
}

// draw() is called ~60 times per sec,
// resulting in a "flip book" effect
void draw() {
    background(#87CEEB); // "Light sky blue"

    // Re-starts every 300 frames
    int frameN = frameCount % 300;
    float frameR = frameN / 300.0;

    // Adds some noise to sun position
    float jitterX = random(-20, 20);
    float jitterY = random(-20, 20);

    // Draws a sun, roughly centered
    noStroke();
    fill(#FF4500); // "Orange-red"
    circle(width/2 + jitterX, 
           height/2 + jitterY, 50);
    
    // Displays current frame rate, frame count, etc.
    textSize(28);
    fill(#000000);
    text(frameRate + " fps", 10, 25);
    text(frameCount + " frames drawn so far", 10, 60);
    text(frameN + " of 300 = " + frameR, 10, 95);
}
