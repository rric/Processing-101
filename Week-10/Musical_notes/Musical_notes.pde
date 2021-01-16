/* Music_notes.pde
 *
 * Copyright 2021 Roland Richter
 *
 * Tis program is free software: you can redistribute it and/or modify
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

/* Frequencies of musical notes (in Hz, rounded to integers) taken from
 * https://de.wikipedia.org/wiki/Frequenzen_der_gleichstufigen_Stimmung,
 * starting with C1, D1, ..., i.e. C1 -> FreqC[0], A4 -> FreqA[3] etc.
 */
final int[] FreqC  = { 33, 65, 131, 262, 523, 1046, 2093};
final int[] FreqCs = { 35, 69, 139, 277, 554, 1109, 2217};
final int[] FreqD  = { 37, 73, 147, 294, 587, 1175, 2349};
final int[] FreqDs = { 39, 78, 156, 311, 622, 1245, 2489};
final int[] FreqE  = { 41, 82, 165, 330, 659, 1319, 2637};
final int[] FreqF  = { 44, 87, 175, 349, 698, 1397, 2794};
final int[] FreqFs = { 46, 92, 185, 370, 740, 1480, 2960};
final int[] FreqG  = { 49, 98, 196, 392, 784, 1568, 3136};
final int[] FreqGs = { 52, 104, 208, 415, 831, 1661, 3322};
final int[] FreqA  = { 55, 110, 220, 440, 880, 1760, 3520};
final int[] FreqAs = { 58, 117, 233, 466, 932, 1865, 3729};
final int[] FreqB  = { 62, 123, 247, 494, 988, 1976, 3951};

void setup() {
    size(900, 600);
    frameRate(60);
}


TriOsc triSound = new TriOsc(this);

StringList songNotes = new StringList();
int playIndex = 0;
int playAge = 0;


void playNote(String note) {
    if (note.length() < 2) {
        triSound.stop();
        return;
    }

    float amplitude = 0.5;

    char ch = note.charAt(0);
    boolean isSharp = (note.charAt(1) == '#');
    int  i = int(note.charAt(note.length()-1)-'0');

    println("Play note:", ch, (isSharp ? "#" : ""), i);

    switch (ch) {
    case 'C':
        if (isSharp) {
            triSound.play(FreqCs[i], amplitude);
        } else {
            triSound.play(FreqC[i], amplitude);
        }
        break;
    case 'D': 
        if (isSharp) {
            triSound.play(FreqDs[i], amplitude);
        } else {
            triSound.play(FreqD[i], amplitude);
        }
        break;
    case 'E': 
        triSound.play(FreqE[i], amplitude); 
        break;
    case 'F': 
        if (isSharp) {
            triSound.play(FreqFs[i], amplitude);
        } else {
            triSound.play(FreqF[i], amplitude);
        }
        break;
    case 'G': 
        if (isSharp) {
            triSound.play(FreqGs[i], amplitude);
        } else {
            triSound.play(FreqG[i], amplitude);
        }
        break;
    case 'A': 
        if (isSharp) {
            triSound.play(FreqAs[i], amplitude);
        } else {
            triSound.play(FreqA[i], amplitude);
        }
        break;
    case 'B': 
        triSound.play(FreqB[i], amplitude); 
        break;
    }
}

/*    y:  120  150  180  210  240  270  300  330  360
 * note:  F4   E4   D4   C4   B3   A3   G3   F3   E3
 */
boolean isCloseTo(int v, int value) {
    return (v - value >= -15 && v - value < 15);
}

String convertY2Note(int y) {
    String note = "";

    if (isCloseTo(y, 120)) {
        note = "F4";
    } else if (isCloseTo(y, 150)) {
        note = "E4";
    } else if (isCloseTo(y, 180)) {
        note = "D4";
    } else if (isCloseTo(y, 210)) {
        note = "C4";
    } else if (isCloseTo(y, 240)) {
        note = "B3";
    } else if (isCloseTo(y, 270)) {
        note = "A3";
    } else if (isCloseTo(y, 300)) {
        note = "G3";
    } else if (isCloseTo(y, 330)) {
        note = "F3";
    } else if (isCloseTo(y, 360)) {
        note = "E3";
    }

    return note;
}


int convertNote2Y(String note) {
    int y = 0;

    if (note.equals("F4") || note.equals("F#4")) {
        y = 120;
    } else if (note.equals("E4")) {
        y = 150;
    } else if (note.equals("D4") || note.equals("D#4")) {
        y = 180;
    } else if (note.equals("C4") || note.equals("C#4")) {
        y = 210;
    } else if (note.equals("B3")) {
        y = 240;
    } else if (note.equals("A3") || note.equals("A#3")) {
        y = 270;
    } else if (note.equals("G3") || note.equals("G#3")) {
        y = 300;
    } else if (note.equals("F3") || note.equals("F#3")) {
        y = 330;
    } else if (note.equals("E3")) {
        y = 360;
    }

    return y;
}


void mousePressed() {
    String note = convertY2Note(mouseY);
    
    if (note.length() >= 2 && keyPressed && key == '#') {
        if (note.charAt(0) != 'E' && note.charAt(0) != 'B') {
            String oldNote = note;
            note = str(oldNote.charAt(0)) + str('#') 
                    + str(oldNote.charAt(1));
        }
    }
    
    println("New note:", note);

    if (note.length() >= 2) {
        songNotes.append(note);
    }
}


void draw() {
    ellipseMode(RADIUS);
    strokeWeight(3);
    textSize(20);
    
    background(255);

    fill(0);
    for (int l = 0; l < 5; l++) {
        line(0, 120 + l*60, width, 120 + l*60);
    }

    for (int n = 0; n < songNotes.size(); n++) {
        int x = 50 + 50*n;
        int y = convertNote2Y(songNotes.get(n));
        ellipse(x, y, 16, 12);
        line(x+15,y,x+15,y-65);
        if (songNotes.get(n).charAt(1) == '#') {
            text('#', x-30, y+5);
        }
    }

    playAge--;
    
    if (playAge <= 0) {
        if (songNotes.size() > 0) {
            
            if (playIndex < songNotes.size()) {
                playNote(songNotes.get(playIndex));
                playAge = 30;
                playIndex++;
            } else {
                playNote("");
                playAge = 90;
                playIndex = 0;              
            }
        }
    }
}
