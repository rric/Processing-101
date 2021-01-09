/* SpotlightShapes.pde
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
boolean isCamera;
PImage display;

void setup() {
    size(640, 480);

    // Code to initialize camera was copied from the
    // GettingStartedCapture example
    // "FuBK-Testbild.png" by Rotkaeppchen68 is licensed with CC BY-SA 3.0,
    // https://commons.wikimedia.org/w/index.php?curid=42157266
    String[] cameras = Capture.list();

    if (cameras == null) {
        println("Failed to retrieve list of available cameras.");
        source = loadImage("640px-FuBK_testcard_vectorized.png");
        isCamera = false;
    } else if (cameras.length == 0) {
        println("There are no cameras available for capture.");
        source = loadImage("640px-FuBK_testcard_vectorized.png");
        isCamera = false;
    } else {
        println("Available cameras:");
        printArray(cameras);

        // The camera can be initialized directly using an element
        // from the array returned by list():
        source = new Capture(this, cameras[0]);
        isCamera = true;
    }

    // Start capturing the images from the camera
    if (isCamera) {
        ((Capture)source).start();
    }

    display = createImage(source.width, source.height, source.format);
}

float degrees = 0.0;

void mouseWheel(MouseEvent event) {
    float count = event.getCount();
    degrees = wrap180(degrees - 6 * count);
}


color transformPixel(int x, int y, color c) {
    float mouseDist = dist(x, y, mouseX, mouseY);

    float h = wrap360(hue(c) + degrees);
    float s = saturation(c);
    float b = constrain(brightness(c) - 0.5 * mouseDist, 0, 100);

    return color(h, s, b);
}


float wrap180(float value) {
    if (value < -180.) {
        return value + 360.;
    }
    if (value > 180.) {
        return value - 360.;
    }

    return value;
}


float wrap360(float value) {
    if (value < 0.) {
        return value + 360.;
    }
    if (value > 360.) {
        return value - 360.;
    }

    return value;
}


void draw() {
    colorMode(HSB, 360, 100, 100);
    rectMode(CENTER);

    if (isCamera) {
        if (((Capture)source).available()) {
            ((Capture)source).read();
        } else {
            return;
        }
    }

    source.loadPixels();

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
        int loc = 0;

        for (int row = 0; row < source.height; row++) {
            for (int col = 0; col < source.width; col++) {

                color c = source.pixels[loc];

                display.pixels[loc] = transformPixel(col, row, c);

                loc++;
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
    text(frameRate + " fps", width-10, height-15);
}
