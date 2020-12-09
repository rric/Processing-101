// Hello_Class.pde
// Copyright 2020 Roland Richter

// Displays some information about me, in decent blue
// Simply run this sketch; there is no user interaction

size(900, 600);       // Create a canvas large enough,
background(#808EDB);  // with decent blue background

textSize(32);        // Let text be large enough
text("Hello, class!", 10, 30);

text("My name is Roland, and I'm happy to give", 10, 75);
text("this programming lecture.", 10, 110);

text("Currently, I teach math, computer science, and", 10, 170);
text("programming at Khevenhüller Gymnasium Linz.", 10, 215);

text("During my years at JKU, I mainly worked in the", 10, 270);
text("fields of image processing and machine learning.", 10, 315);

text("Over the years, I wrote about 150,000 lines of code,", 10, 370);
text("mainly C, C++, and Java, ...", 10, 415);

text("... but I also used Julia, Prolog, Haskell, Python,", 10, 480);
text("Processing, Arduino, and Scratch from time to time.", 10, 525);

// saveFrame("Hello_Class.png");
