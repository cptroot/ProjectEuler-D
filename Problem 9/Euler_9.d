import std.stdio;
import std.math;

void main() {
  for (int c = 500; c > 333; c--) {
    for (int b = (1000 - c) / 2; b < 1000 - c; b++) {
      int a = 1000 - c - b;
      if (a * a + b * b == c * c) {
        writeln(a * b * c);
        return ;
      }
    }
  }
}