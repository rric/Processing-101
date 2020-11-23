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
    frameRate(0.33);
    
    textSize(36);
    background(0);
}


void draw() {
    background(0);
    
    for (int i = 0; i < 24; i++) {
        drawLeaf(random(0,width), random(0,height), 
                  random(TWO_PI), 0.1);
    }
    
    fill(128);
    for (int line = 0; line < poem.length; line++) {
        text(poem[line], 16, height - 200 + line*46);
    }
}


/** Draws a maple leaf at a certain position, rotated and scaled.
 *
 * @param posX   the x position of the leaf
 * @param posY   the y position of the leaf
 * @param rt     the angle to rotate the leaf, between 0 and TWO_PI
 * @param sc     the factor to scale the leaf
 * 
 * The "Yellow Autumn Maple Leaves" photo served as a reference 
 * image to create the code below, using the "Art Station" tool,
 * with minor tweaks added.
 *
 * "Yellow Autumn Maple Leaves" by Stanley Zimny is licensed 
 * with CC BY-NC 2.0.
 */

void drawLeaf(float posX, float posY, float rt, float sc) {
    fill(-6554);
    strokeWeight(1.0);
    stroke(-6737152);
    pushMatrix();
    
    translate(posX, posY);
    rotate(rt);
    scale(sc);
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
