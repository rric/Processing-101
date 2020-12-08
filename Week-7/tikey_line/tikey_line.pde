/* tikey_line.pde
 *
 * Copyright 2020 Roland Richter
 *
 * tikey_line is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty
 * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
 * See the GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program. If not, see <http://www.gnu.org/licenses/>.
 */

/* This program is inspired by Martin Kleppe's https://tixy.land/. 
   tixy.land is a 16 x 16 grid of dots; their size and color is 
   controlled by a formula returning a value between -1.0 and +1.0:
   
   - abs(value), the value without sign, is the diameter of each 
     dot, between 0.0 (invisible) and 1.0 (as large as possible)
   - if value > 0, the dot is painted in white, otherwise in red
   
   tikey_line shows a line of 16 dots, where an array of 16 values 
   controls their size and color in the same manner as above. 
   Additionally, one may switch between circular dots, and square
   boxes. Unlike tixy.land, tikey_line allows the user to control 
   the 16 values directly by keybord inputs.
 */

enum Shape {DOT, BOX};
Shape[] shapes = new Shape[16]; // 16 shapes, circle or square
float[] values = new float[16]; // 16 values between -1.0 and +1.0

int cursorPos = 0;
boolean showText = true;


void setup() {
    size(1024, 256);
    frameRate(60);
    
    // Draws circles, squares, and text aligned
    ellipseMode(CENTER);
    rectMode(CENTER);
    
    textSize(16);
    textAlign(CENTER);

    // The sketch starts with 16 white dots of medium size
    for (int i = 0; i < shapes.length; i++) {
        shapes[i] = Shape.DOT;
    }

    for (int i = 0; i < values.length; i++) {
        values[i] = 0.5;
    }
}


void keyPressed() {
    // Handles several keys to modify values, shapes, etc.
    // The current value is indicated by the ^ cursor.
    //
    //   0-9 ... enter the current value, e.g. "3" => +0.3
    //   + ... increase the current value
    //   - ... decrease the current value
    //   r ... all values are set to random values
    //   c ... change shape, switch between dot and box
    //   t ... show/hide text
    //   ←/→ ... move the cursor to the left or to the right
    
    // If the text is hidden, you can't do anything ... except
    // making the text visible again.
    if (showText == false) {
        if (key == 't') {
            showText = true;    
        }
        
        return;
    }

    if (key >= '0' && key <= '9') {
        float newValue = float(key - '0') / 10.0;

        values[cursorPos] = newValue;

        // Moves the cursor to the right, if possible
        if (cursorPos < 15) {
            cursorPos += 1;
        }
    }

    if (key == 'r') {
        for (int i = 0; i < values.length; i++) {
            // The command `values[i] = random(-1.0, +1.0);`
            // would generate numbers such as 0.34919, -0.98129, etc.
            // To get numbers -1.0, -0.9, -0.8, ..., 0.0, +0.1, ..., +1.0,
            // a random integer number between -10 and +10 is generated,
            // then mapped to the range between -1.0 to +1.0
            values[i] = map(int(random(-10, 10)), -10, +10, -1.0, +1.0);
        }
    }

    if (key == '+') {
        values[cursorPos] = constrain(values[cursorPos] + 0.1, 
                                       -1.0, +1.0);
    }

    if (key == '-') {
        values[cursorPos] = constrain(values[cursorPos] - 0.1, 
                                       -1.0, +1.0);
    }
    
    if (key == 'c') {
        if (shapes[cursorPos] == Shape.DOT) {
            shapes[cursorPos] = Shape.BOX;
        } else {
            shapes[cursorPos] = Shape.DOT;
        }
    }    
    
    if (key == CODED) {
        if (keyCode == LEFT) {
            if (cursorPos > 0) {
                cursorPos -= 1;
            }
        }

        if (keyCode == RIGHT) {
            if (cursorPos < 15) {
                cursorPos += 1;
            }
        }
    }
    
    if (key == 't') {
        showText = !showText;    
    }    
}


void draw() {
    background(0);
    
    if (showText) {
        fill(128);
        text("0-9 ... enter value, + ... increase, - ... decrease, "
             + "r ... random values, c ... change shape, "
             + "t ... show/hide text, ←/→ ... move cursor", width/2, 240);
    }

    float wiggle = 8.0 * sin(HALF_PI * frameCount / 60.0);

    // Draws all 16 dots in a line
    for (int i = 0; i < values.length; i++) {
        int posX = 32 + 64 * i;
        int posY = 92;

        // abs(value), the value without sign, is the diameter of 
        // the dot, between 0.0 (invisible) and 1.0 (as large as 
        // possible); the largest possible diameter is 64
        float diameter = 64 * abs(values[i]);
        
        // if value > 0, the dot is painted white, otherwise red
        if (values[i] >= 0) {
            fill(#FFFFFF);
        } else {
            fill(#FF0000);
        }

        // Draws the shape, either as a dot, or a box
        if (shapes[i] == Shape.DOT) {
            circle(posX + wiggle, posY, diameter);
        } else if (shapes[i] == Shape.BOX) {
            square(posX + wiggle, posY, diameter);
        }

        // Displays the values array, and the cursor
        if (showText) {
            // Always shows the sign of the value, i.e.
            //   0.4 => "+0.4", and -0.1 => "-0.1"
            text(nfp(values[i], 1, 1), posX, posY + 64);
    
            if (i == cursorPos) {
                text('^', posX, posY + 92);
            }
        }
    }
}
