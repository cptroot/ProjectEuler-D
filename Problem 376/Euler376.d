import std.stdio;
import std.conv;

void main() {
  write("Max Num: ");
  int max = to!string(readln());
  write("Number of sides: ");
  int numSides = to!string(readln());
  
}

struct Die {
  int[] sides;
  int max;
  int numSides; 

  int opUnary(string s)() if (s == "++") {
    sides[0]++;
    int i = 0;
    while (i < sides.length && sides[i] == max) {
      sides[i] = 0;
      if (i + 1 != sides.length)
        sides[i + 1]++;
    }
  }
}