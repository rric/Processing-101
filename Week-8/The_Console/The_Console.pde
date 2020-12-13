
void heading(String h) {
    delay(200);
    println(); 
    println();
    println(h);
}


void setup() {
    size(240, 160);
    frameRate(2);

    PFont font = loadFont("SourceCodePro-Regular-16.vlw");
    textFont(font);


    heading("--- integer arithmetic ---");
    int m = 35;
    int n = 4;

    println("m ...", m);
    println("n ...", n);
    println("m + n ...", m + n);
    println("m - n ...", m - n);
    println("m * n ...", m * n);
    println("m / n ...", m / n);
    println("m % n ...", m % n);

    heading("--- more integer arithmetic ---");
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

    heading("--- floating point arithmetic ---");
    float u = 35.01;
    float v = 4.01;

    println("u ...", u);
    println("v ...", v);
    println("u + v ...", u + v);
    println("u - v ...", u - v);
    println("u * v ...", u * v);
    println("u / v ...", u / v);


    heading("--- boolean expressions ---");
    int a = 12;
    int b = 30;
    int c = 42;
    println("a, b, c ...", a, b, c);
    
    println("a < b ? ...",  a < b);
    println("a == b ? ...", a == b);
    println("a != b ? ...", a != b);
    println("a > b ? ...",  a > b);
    
    println("a + b <= c ? ...", a <= b);
    println("a + b == c ? ...", a == b);
    println("a + b != c ? ...", a != b);
    println("a + b >= c ? ...", a >= b);
    

    heading("--- char ---");
    
    println("your turn :-)");
    

    heading("--- color ---");
    
    color neongreen = #39FF14;
    
    println("neongreen ...", neongreen);
    println("hex(neongreen) ...", hex(neongreen));
    println("binary(neongreen) ...", binary(neongreen));


    heading("--- Strings ---");

    String text = "Cry \"havoc!\" and let slip the dogs of war";
    
    println("text ...", text);
    for (int i = 0; i < 8; i++) {
        println("text.charAt(", i , ") ...", text.charAt(i));
    }
    println("etc.");


    heading("--- for loops ---");

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

    heading("--- array with random numbers ---");

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

    heading("--- array access ---");
    

    heading("--- ASCII patterns ---");
    
    for (int row = 0; row < 13; row++) {
        for (int col = 0; col < row; col++) {
            print("*");
        }
        println();
    }
}


boolean blink = true;

void draw() {
    background(#000000);
    fill(#39FF14); // Neon green

    if (blink) {
        text(">_", 5, 20);
    } else {
        text("> ", 5, 20);
    }

    blink = !blink;
}
