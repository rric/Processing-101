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

Capture video;

void setup() {
    size(640, 480);
    frameRate(30);

    // Copied from GettingStartedCapture example
    String[] cameras = Capture.list();

    if (cameras == null) {
        println("Failed to retrieve list of available cameras, will try default ...");
        video = new Capture(this, 640, 480);
    } else if (cameras.length == 0) {
        println("There are no cameras available for capture.");
        exit();
    } else {
        println("Available cameras:");
        printArray(cameras);

        // The camera can be initialized directly using an element
        // from the array returned by list():
        video = new Capture(this, cameras[0]);
        // Or, the settings can be defined based on the text in the list
        //cam = new Capture(this, 640, 480, "Built-in iSight", 30);
    }

    // Start capturing the images from the camera
    video.start();
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

    if (video.available()) {
        video.read();
        video.loadPixels();

        background(0);

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
        
        int refLoc = width/2 +  video.width * (height/2 + 20);
        
        for (int loc = 0; loc < video.width * video.height; loc++) {
            color c = video.pixels[loc];
            float h = wrap360(hue(c) + getMouseDegrees());
            float s = saturation(c);
            float b = constrain(brightness(c) - getMouseDist(), 0, 100);
            video.pixels[loc] = color(h, s, b);
            
            if (loc == refLoc) {
                println(hue(c), s, brightness(c), " => ", h, s, b);
            }
        }

        video.updatePixels();
        image(video, 0, 0, width, height);
        // --- end of variant 2 ---
    }

    // image(cam, 0, 0, width, height);

    float mouseDist= getMouseDist();
    float mouseDegrees = getMouseDegrees();

    textSize(12);
    stroke(0, 0, 99);
    noFill();
    text(mouseDist + " pxls", width-300, height-15);
    text(mouseDegrees + " deg", width-200, height-15);
    text(frameRate + " fps", width-100, height-15);
    circle(width/2, height/2 + 20, 5);
}
