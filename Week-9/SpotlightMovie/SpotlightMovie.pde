/* SpotlightMovie.pde
 *
 * Copyright 2021 Roland Richter
 *
 * This program is free software: you can redistribute it and/or modify
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

import processing.video.*;

PImage source;
boolean isMovie;
PImage display;

void setup() {
    size(720, 480);
    
    source = new Movie(this, "SpotlightMovie.mp4");
    
    if (source == null) {
        println("Failed to retrieve SpotlightMovie.mp4.");
        source = loadImage("640px-FuBK_testcard_vectorized.png");
        isMovie = false;
    } else {
        ((Movie)source).play();
        
        // Read the first frame s.t. source.width and 
        // source.height are defined
        ((Movie)source).read();
        
        isMovie = true;
    }

    println("Create", source.width, "x", source.height, "image of format", source.format);
    display = createImage(source.width, source.height, source.format);
}

float degrees = 0.0;

void mouseWheel(MouseEvent event) {
    float count = event.getCount();
    degrees = wrap360(degrees - 6 * count);
}


color transformPixel(int x, int y, color c) {
    float mouseDist = dist(x, y, mouseX, mouseY);

    float h = wrap360(hue(c) + degrees);
    float s = saturation(c);
    float b = constrain(brightness(c) - 0.5 * mouseDist, 0, 100);

    return color(h, s, b);
}


float wrap360(float value) {
    if (value < 0.) {
        return value + 360.;
    }
    if (value >= 360.) {
        return value - 360.;
    }

    return value;
}


void draw() {
    colorMode(HSB, 360, 100, 100);
    rectMode(CENTER);

    if (isMovie) {
        if (((Movie)source).available()) {
            ((Movie)source).read();
        }
    }

    if (mousePressed && (mouseButton == LEFT)) {
        // Variant 3: fast again, because only every 20th
        // row and column is processed
        background(0);

        for (int row = 0; row < source.height; row += 20) {
            for (int col = 0; col < source.width; col += 20) {
                color c = source.get(col, row);
                stroke(c);
                fill(c);

                float h = wrap360(hue(c) + degrees);
                if (h <= 60 || h > 300) { 
                    rect(col, row, 12, 8);
                } else if (h > 60 && h <= 180) {
                    circle(col, row, 10);
                } else {
                    triangle(col, row+6, col+6, row-6, col-6, row-6);
                }
            }
        }
        // --- end of variant 3 ---
    } else {
        // --- Variant 2: much faster, stable > 20 fps ---
        source.loadPixels();

        int idx = 0;

        for (int row = 0; row < source.height; row++) {
            for (int col = 0; col < source.width; col++) {

                color c = source.pixels[idx];

                display.pixels[idx] = transformPixel(col, row, c);

                idx++;
            }
        }

        display.updatePixels();
        image(display, 0, 0);
        // --- end of variant 2 ---
    }

    textSize(12);
    textAlign(RIGHT);
    fill(0, 0, 99);

    text(degrees + " deg", 80, height-15);
    
    if (isMovie) {
        text(((Movie)source).time() + "/" + 
             ((Movie)source).duration() + " s", width-10, height-15);
    } else {
        text(frameRate + " fps", width-10, height-15);
    }
    
    saveFrame("film-####.tif");
}
