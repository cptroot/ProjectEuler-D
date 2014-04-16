import std.stdio;

import sieve;

void main() {
  bool[] sieve = Sieve(1_000_000);
  int product = 0;
  int max = 0;
  foreach (a;-999..1000) {
    foreach (b;2..1000) {
      int n = 0;
      int value = b;
      while (!sieve[value - 2]) {
        n++;
        value = n * n + a * n + b;
        if (value < 2 || value > 999_998) value = 4;
      }
      if (n - 1 > max) {
        product = a * b;
        writeln(a, " ", b, " ", n - 1);
        max = n - 1;
      }
    }
  }
  writeln(product);
}