/* Maple_leaf.pde
 *
 * Copyright 2020 Roland Richter
 *
 * The "Yellow Autumn Maple Leaves" photo served as a reference 
 * image to create the code below, using the "Art Station" tool,
 * with minor tweaks added.
 *
 * "Yellow Autumn Maple Leaves" by Stanley Zimny is licensed 
 * with CC BY-NC 2.0.
 */

void setup(){
    size(960, 720);
}

void draw(){ 
    background(-777);

    fill(-6554);
    strokeWeight(1.0);
    stroke(-6737152);
    pushMatrix();
    translate(485, 639);
    rotate(0.0);
    scale(1.0);
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
