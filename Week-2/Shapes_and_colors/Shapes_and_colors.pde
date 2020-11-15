// Creates a 600×450 canvas with
// "Light sky blue" background
size(600, 450);
background(#87CEEB);

// Creates the setting sun
noStroke();    // What does this do?
fill(#FFCC33); // "Sunglow"
circle(0.5*width, 0.5*height, 80);

// Creates the ocean
stroke(#004242); // "Warm black"
fill(#0077BE);   // "Ocean Boat Blue"
rect(0, 0.55*height, width, 0.5*height);

rectMode(CENTER);
noStroke();
fill(#F28500); // "Tangerine"
rect(0.5*width, 0.60*height, 100, 5);
rect(0.5*width, 0.65*height, 150, 5);
rect(0.5*width, 0.70*height, 200, 5);
rect(0.5*width, 0.75*height, 250, 5);
