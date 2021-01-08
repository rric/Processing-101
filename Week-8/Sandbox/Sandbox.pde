size(320, 240);

// --- print ---
print(width, "x", height);
print("...is a square?", 
        width == height);
        
println();
println();
// --- println, printArray ---
int[] primes = {2, 3, 5, 7};
println("first", primes.length, "primes:");
printArray(primes);

// --- floating point arithmetic ---
float u = 35.01;
float v = 4.01;
println("u + v ...", u + v);
println("u - v ...", u - v);
println("u * v ...", u * v);
println("u / v ...", u / v);

// --- if-then-else ---
int die = int(random(1,7));
print("die is", die);
if (die <= 3) {
    println(" i.e. less than 4");
} else {
    println(" i.e. greater than 3");
}

// --- for-loops ---
for (int i = 0; i < 7; i++) {
    print(i, "->");
}
println();
for (int j = 0; j <= 6; j = j + 1) {
    print(j, "->");
}

println();
for (int row = 0; row < 8; row++) {
    for (int col = 0; col < row; col++) {
        print("*");
    }
    println();
}

println();
for (int row = 0; row < 8; row++) {
    print("row = ", row, ": col = ");
    for (int col = 0; col < row; col++) {
        print(col, " ");
    }
    println();
}
