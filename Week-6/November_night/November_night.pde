/* November_Night.pde
 *
 * Copyright 2020 Roland Richter
 *
 * November_Night is free software: you can redistribute it and/or modify
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

// Text taken from 
// https://interestingliterature.com/2018/03/a-short-analysis-of-adelaide-crapseys-november-night/

String poet  = "Adelaide Crapsey";
String title = "November Night";
String[] poem = { "Listen ...",
                  "With faint dry sound,",
                  "Like steps of passing ghosts,",
                  "The leaves, frost-crisp'd, break from the trees",
                  "And fall."};


void setup() {
    fullScreen();
    frameRate(0.5);
    
    textSize(28);
    background(0);
}


void draw() {
    background(0);
    
    // Draws the poem's title in the upper left corner,
    // the poem itself in the lower left corner,
    // the poet's name in the lower right corner.
    fill(192);
    
    textAlign(LEFT);
    text(title, 16, 46);
    
    for (int line = 0; line < poem.length; line++) {
        text(poem[line], 16, height-200+line*46);
    }
    
    textAlign(RIGHT);
    text("- " + poet, width-16, height-200+4*46);
    
    // Draws 24 random leaves on the screen
    for (int i = 0; i < 24; i++) {
        drawLeaf(random(0, width), random(0, height), 
                 random(TWO_PI), random(0.04,0.2));
    }
}


/** Draws a maple leaf at a certain position, rotated and scaled.
 *
 * @param xPos   the x position of the leaf
 * @param yPos   the y position of the leaf
 * @param angle  the angle to rotate the leaf, between 0 and TWO_PI
 * @param zoom   the factor to scale the leaf
 * 
 * The "Yellow Autumn Maple Leaves" photo served as a reference 
 * image to create the code below, using the "Art Station" tool,
 * with minor tweaks added.
 *
 * "Yellow Autumn Maple Leaves" by Stanley Zimny is licensed 
 * with CC BY-NC 2.0.
 */
void drawLeaf(float xPos, float yPos, float angle, float zoom) {
    fill(#ffe680);
    strokeWeight(1.0);
    stroke(#1a1a1a);
    
    pushMatrix();
    translate(xPos, yPos);
    rotate(angle);
    scale(zoom);
    
    beginShape();
    vertex(0.0, 0.0);
    vertex(-76.725006, 25.575012);
    vertex(-179.025, 0.0);
    vertex(-76.725006, -25.574951);
    vertex(-179.025, -76.724976);
    vertex(-306.90002, -204.59998);
    vertex(-153.45001, -153.44998);
    vertex(-204.6, -281.32498);
    vertex(-230.17502, -409.2);
    vertex(-179.025, -383.625);
    vertex(-102.30002, -332.47498);
    vertex(-51.149994, -204.59998);
    vertex(-51.149994, -358.05);
    vertex(0.0, -434.775);
    vertex(76.725006, -537.075);
    vertex(76.725006, -358.05);
    vertex(102.30002, -281.32498);
    vertex(153.44998, -306.9);
    vertex(281.32498, -358.05);
    vertex(230.17502, -281.32498);
    vertex(204.6, -204.59998);
    vertex(179.025, -153.44998);
    vertex(102.30002, -102.29999);
    vertex(204.6, -153.44998);
    vertex(281.32498, -179.025);
    vertex(230.17502, -76.724976);
    vertex(127.87503, -25.574951);
    vertex(179.025, 0.0);
    vertex(102.30002, 25.575012);
    endShape(CLOSE);
    popMatrix();
}
