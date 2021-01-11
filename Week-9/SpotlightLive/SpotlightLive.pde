/* SpotlightLive.pde
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

    if (isCamera) {
        if (((Capture)source).available()) {
            ((Capture)source).read();
        } else {
            return;
        }
    }

    // --- Variant 1: very slow, ~ 3 fps and decreasing! ---
    //for (int row = 0; row < source.height; row++) {
    //    for (int col = 0; col < source.width; col++) {
    //        color c = source.get(col, row);
    //        color newc = transformPixel(col, row, c);
    //        stroke(newc);
    //        point(col, row);
    //    }
    //}
    // --- end of variant 1 ---

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

    textSize(12);
    textAlign(RIGHT);
    fill(0, 0, 99);

    text(degrees + " deg", 80, height-15);
    text(frameRate + " fps", width-10, height-15);
}
