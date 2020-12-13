/* Two_Consoles.pde
 *
 * Copyright 2020 Roland Richter
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

import at.mukprojects.console.*;

Console console;
boolean paused = false;
int tick = 0;

PFont sourceCodefont;

void setup() {
    size(640, 480);
    frameRate(2);

    // Initialize and start the console 
    console = new Console(this);
    console.start();

    sourceCodefont = loadFont("SourceCodePro-Regular-16.vlw");
}

final color NeonGreen = #39FF14;

void draw() {
    fill(0);
    rect(0, 0, width, 80);
    
    textFont(sourceCodefont);
    textSize(16);
    fill(NeonGreen); // Neon green
    text("> " + (paused ? "paused" : "run " + (tick % 10)), 5, 15);

    if (paused) {
        return;
    }

    if (tick % 10 == 0) {
        println("--- integer arithmetic ---");
        int m = 35;
        int n = 4;

        println("m ...", m);
        println("n ...", n);
        println("m + n ...", m + n);
        println("m - n ...", m - n);
        println("m * n ...", m * n);
        println("m / n ...", m / n);
        println("m % n ...", m % n);
    }

    if (tick % 10 == 0) {
        int m = 35;
        int n = 4;
        println("--- more integer arithmetic ---");
        println("m ...", m);
        m += 5;
        println("m += 5; => m ...", m);
        m -= 15;
        println("m -= 15; => m ...", m);
        m++;
        println("m++; => m ...", m);
        ++m;
        println("++m; => m ...", m);

        println("n ...", n);
        n *= 3;
        println("n *= 3; => n ...", n);
        n /= 6;
        println("n /= 6; => n ...", n);
    }

    if (tick % 10 == 2) {
        println("--- floating point arithmetic ---");
        float u = 35.01;
        float v = 4.01;

        println("u ...", u);
        println("v ...", v);
        println("u + v ...", u + v);
        println("u - v ...", u - v);
        println("u * v ...", u * v);
        println("u / v ...", u / v);
    }

    if (tick % 10 == 3) {
        println("--- boolean expressions ---");
        int a = 12;
        int b = 30;
        int c = 42;
        println("a, b, c ...", a, b, c);

        println("a < b ? ...", a < b);
        println("a == b ? ...", a == b);
        println("a != b ? ...", a != b);
        println("a > b ? ...", a > b);

        println("a + b <= c ? ...", a <= b);
        println("a + b == c ? ...", a == b);
        println("a + b != c ? ...", a != b);
        println("a + b >= c ? ...", a >= b);
    }

    if (tick % 10 == 4) {
        println("--- char ---");

        println("your turn :-)");
    }

    if (tick % 10 == 5) {
        println("--- color ---");

        println("neongreen ...", NeonGreen);
        println("hex(neongreen) ...", hex(NeonGreen));
        println("binary(neongreen) ...", binary(NeonGreen));
    }

    if (tick % 10 == 6) {
        println("--- Strings ---");

        String text = "Cry \"havoc!\" and let slip the dogs of war";

        println("text ...", text);
        for (int i = 0; i < 8; i++) {
            println("text.charAt(", i, ") ...", text.charAt(i));
        }
        println("etc.");
    }

    if (tick % 10 == 7) {
        println("--- for loops ---");

        println("for (int i = 0; i < 7; i++) ...");
        for (int i = 0; i < 7; i++) {
            println("    i ...", i);
        }

        println("for (int j = 0; j <= 6; j = j + 1) ...");
        for (int j = 0; j <= 6; j = j + 1) {
            println("    j ...", j);
        }

        println("for (int k = 42; k >= 0; k = k - 7) ...");
        for (int k = 42; k >= 0; k = k - 7) {
            println("    k ...", k);
        }
    }

    if (tick % 10 == 8) {
        println("--- array with random numbers ---");

        int[] dice = new int[10];

        randomSeed(42);

        for (int k = 0; k < 10; k++) {
            dice[k] = int(random(1, 7));
        }

        println("dice ...");
        printArray(dice);

        dice = sort(dice);
        println("dice = sort(dice); => dice ...");
        printArray(dice);
    }

    if (tick % 10 == 9) {
        println("--- ASCII patterns ---");

        for (int row = 0; row < 13; row++) {
            for (int col = 0; col < row; col++) {
                print("*");
            }
            println();
        }
    }

    // Print the console to the system out.
    console.print();

    // Draw the console to the screen. 
    // (x, y, width, height, preferredTextSize, minTextSize, linespace, padding, strokeColor, backgroundColor, textColor)
    console.draw(0, 80, width, height, 16, 16, 4, 4, color(255), color(0), NeonGreen);
    
    tick++;
}


void keyPressed() {
    if (key == ESC || key == 'q' || key == 'Q') {
        exit();
    } 
        
    if (key == 'p' || key == 'P') {
        paused = true;
    }
    
    if (key == 'r' || key == 'R') {
        paused = false;
    }    
}
