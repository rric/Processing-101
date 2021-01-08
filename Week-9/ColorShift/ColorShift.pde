/* ColorShift.pde
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

    // Copied from GettingStartedCapture example
    String[] cameras = Capture.list();

    if (cameras == null) {
        println("Failed to retrieve list of available cameras");
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

// Returns
float getMouseDist() {
    float maxDist = dist(width/2, height/2, 0, 0);
    float mouseDist = dist(width/2, height/2, mouseX, mouseY);

    return map(mouseDist, 0, maxDist, 0, 100.);
}


// Returns
float getMouseDegrees() {
    float deg = degrees(atan2(height/2-mouseY, mouseX-width/2));
    return deg;
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

    if (isCamera) {
        if (((Capture)source).available()) {
            ((Capture)source).read();
        } else {
            return;
        }
    }

    source.loadPixels();

    // --- Variant 1: very slow, ~ 3 fps and decreasing! ---
    //for (int row = 0; row < video.height; row++) {
    //    for (int col = 0; col < video.width; col++) {
    //        color c = video.get(col, row);
    //        float h = wrap360(hue(c) + getMouseDegrees());
    //        float s = saturation(c);
    //        float b = constrain(brightness(c) - getMouseDist(), 0, 100);
    //        stroke(h, s, b);
    //        point(col, row);
    //    }
    //}
    // --- end of variant 1 ---

    // --- Variant 2: much faster, stable > 20 fps ---
    int refLoc = width/2 +  source.width * (height/2 + 20);

    for (int loc = 0; loc < source.width * source.height; loc++) {
        color c = source.pixels[loc];
        float h = wrap360(hue(c) + getMouseDegrees());
        float s = saturation(c);
        float b = constrain(brightness(c) - getMouseDist(), 0, 100);
        display.pixels[loc] = color(h, s, b);

        if (loc == refLoc) {
            println(hue(c), s, brightness(c), " => ", h, s, b);
        }
    }

    display.updatePixels();
    image(display, 0, 0);
    // --- end of variant 2 ---

    float mouseDist = getMouseDist();
    float mouseDegrees = getMouseDegrees();

    textSize(12);
    stroke(0, 0, 99);
    noFill();
    text(mouseDist + " pxls", width-300, height-15);
    text(mouseDegrees + " deg", width-200, height-15);
    text(frameRate + " fps", width-100, height-15);
    circle(width/2, height/2 + 20, 5);
}
