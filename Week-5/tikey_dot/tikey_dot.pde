/* tikey_dot.pde
 *
 * Copyright 2020 Roland Richter
 *
 * tikey_dot is free software: you can redistribute it and/or modify
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
   
   tikey_dot shows only one dot, where a value controls its size and
   color in the same manner as above. Additionally, one may switch 
   between a circular dot, and a square box. Unlike tixy.land, tikey_dot
   allows the user to control the value directly by keybord inputs.
 */

enum Shape {DOT, BOX};
Shape shape;   // circle or square
float value;   // value between -1.0 and +1.0

boolean showText = true;


void setup() {
    size(1024, 256);
    frameRate(60);
    
    // Draws circles, squares, and text aligned
    ellipseMode(CENTER);
    rectMode(CENTER);
    
    textSize(16);
    textAlign(CENTER);

    // The sketch starts with a white dot of medium size
    shape = Shape.DOT;
    value = 0.5;
}


void keyPressed() {
    // Handles several keys to modify values, shapes, etc.
    //
    //   0-9 ... enter the current value, e.g. "3" => +0.3
    //   + ... increase the current value
    //   - ... decrease the current value
    //   r ... the value is set to a random value
    //   c ... change shape, switch between dot and box
    //   t ... show/hide text
    
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

        value = newValue;
    }

    if (key == 'r') {
        // The command `value = random(-1.0, +1.0);`
        // would generate numbers such as 0.34919, -0.98129, etc.
        // To get numbers -1.0, -0.9, -0.8, ..., 0.0, +0.1, ..., +1.0,
        // a random integer number between -10 and +10 is generated,
        // then mapped to the range between -1.0 to +1.0
        value = map(int(random(-10, 10)), -10, +10, -1.0, +1.0);
    }

    if (key == '+') {
        value = constrain(value + 0.1, -1.0, +1.0);
    }

    if (key == '-') {
        value = constrain(value - 0.1, -1.0, +1.0);
    }
    
    if (key == 'c') {
        if (shape == Shape.DOT) {
            shape = Shape.BOX;
        } else {
            shape = Shape.DOT;
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
             + "r ... random value, c ... change shape, "
             + "t ... show/hide text", width/2, 240);
    }

    float wiggle = 8.0 * sin(HALF_PI * frameCount / 60.0);

    // Draws the dot in the center of the screen
    int posX = width/2;
    int posY = 92;

    // abs(value), the value without sign, is the diameter of 
    // the dot, between 0.0 (invisible) and 1.0 (as large as 
    // possible); the largest possible diameter is 64
    float diameter = 64 * abs(value);
    
    // if value > 0, the dot is painted white, otherwise red
    if (value >= 0) {
        fill(#FFFFFF);
    } else {
        fill(#FF0000);
    }

    // Draws the shape, either as a dot, or a box
    if (shape == Shape.DOT) {
        circle(posX + wiggle, posY, diameter);
    } else if (shape == Shape.BOX) {
        square(posX + wiggle, posY, diameter);
    }

    // Displays the value
    if (showText) {
        // Always shows the sign of the value, i.e.
        //   0.4 => "+0.4", and -0.1 => "-0.1"
        text(nfp(value, 1, 1), posX, posY + 64);
    }
}
