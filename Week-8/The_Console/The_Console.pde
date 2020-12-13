/* The_Console.pde
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

import processing.sound.*;
import at.mukprojects.console.*;

Console console;

PFont sourceCodefont;
final color NeonGreen = #39FF14;

StringDict demoDict = new StringDict();
SoundFile[] keyboardSounds = new SoundFile[5];


void setup() {
    size(640, 720);
    frameRate(60);

    // Initialize and start the console 
    console = new Console(this);
    console.start();

    sourceCodefont = loadFont("SourceCodePro-Regular-16.vlw");
    
    // Pack vintage keyboard by jim-ph used under CC 0
    // https://freesound.org/people/jim-ph/packs/12363/
    keyboardSounds[0] = new SoundFile(this, "194795__jim-ph__vintage-keyboard-1.wav");
    keyboardSounds[1] = new SoundFile(this, "194796__jim-ph__vintage-keyboard-2.wav");
    keyboardSounds[2] = new SoundFile(this, "194797__jim-ph__vintage-keyboard-3.wav");
    keyboardSounds[3] = new SoundFile(this, "194798__jim-ph__vintage-keyboard-4.wav");
    keyboardSounds[4] = new SoundFile(this, "194799__jim-ph__keyboard5.wav");
    
    demoDict.set("int",   "integer arithmetic");
    demoDict.set("float", "floating point arithmetic");
    demoDict.set("dice",  "dice: array with random numbers");
}


String command = new String();
String demoArg = new String();

void keyPressed() {
    // Play a key sound
    int randomIndex = int(random(0,5));
    keyboardSounds[randomIndex].play();
    
    // If the ENTER key was pressed, analyze the command string that
    // was typed in, react accordingly, and clear the command string.
    if (key == ENTER) {
        if (command.equals("exit")) {
            exit();
        }

        if (command.equals("help")) {
            // Print all possible commands
            println("help ... show this list of commands");
            println("exit ... quit the program");
            
            String[] theKeys = demoDict.keyArray();
            String[] theVals = demoDict.valueArray();
            
            for (int k = 0; k < theKeys.length; k++) {
                println("demo", theKeys[k], "...", theVals[k]);
            }
        }

        // If the command is "demo <argument>", store the argument
        // which will then be used within the draw() function;
        // then, clear the command string.
        if (command.length() >= 6 && command.startsWith("demo ")) {
            demoArg = command.substring(5);
        }

        command = "";
    }

    // If BACKSPACE was entered, remove the last character from the
    // comand string, if it is not empty 
    if (key == BACKSPACE) {
        if (command.length() > 0) {
            command = command.substring(0, command.length()-1);
        }
    }

    // If any ordinary ASCII character was entered, just append
    // it to the command string
    if (key >= 32 && key <= 128) {
        command = command + key;
    }
}


void draw() {
    fill(0);
    rect(0, 0, width, 80);

    textFont(sourceCodefont);
    textSize(16);
    fill(NeonGreen); // Neon green

    char cursor = ((frameCount % 60 < 30) ? ' ' : '_');
    text("> " + command + cursor, 5, 15);

    if (demoDict.hasKey(demoArg)) {
        println("---", demoDict.get(demoArg), "---");

        if (demoArg.equals("int")) {
            demo_int();
        }

        if (demoArg.equals("float")) {
            demo_float();
        }

        if (demoArg.equals("dice")) {
            demo_dice();
        }
    }

    // Print the console to the system out.
    console.print();

    // Draw the console to the screen. 
    // (x, y, width, height, preferredTextSize, minTextSize, linespace, padding, strokeColor, backgroundColor, textColor)
    console.draw(0, 80, width, height, 16, 16, 4, 4, color(255), color(0), NeonGreen);

    demoArg = "";    
}


void demo_int() {
    int m = 35;
    int n = 4;

    println("m ...", m);
    println("n ...", n);
    println("m + n ...", m + n);
    println("m - n ...", m - n);
    println("m * n ...", m * n);
    println("m / n ...", m / n);
    println("m % n ...", m % n);

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


void demo_float() {
    float u = 35.01;
    float v = 4.01;

    println("u ...", u);
    println("v ...", v);
    println("u + v ...", u + v);
    println("u - v ...", u - v);
    println("u * v ...", u * v);
    println("u / v ...", u / v);
}


void demo_dice() {
    int[] dice = new int[10];

    // randomSeed(42);
    // println("randomSeed(42);");

    for (int k = 0; k < 10; k++) {
        dice[k] = int(random(1, 7));
    }

    println("dice ...");
    printArray(dice);

    dice = sort(dice);
    println("dice = sort(dice); => dice ...");
    printArray(dice);
}
