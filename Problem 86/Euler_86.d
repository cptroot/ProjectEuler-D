import std.stdio;
import std.math;

void main() {
  int total = 0;
  int M = 0;
  while (total < 1_000_000) {
    M++;
    int value;
    real sqr;
    foreach (i; 1..M + 1) {
      foreach (j; i.. M + 1) {
        value = (i + j) * (i + j) + M * M;
        sqr = sqrt(value);
        if (sqr == floor(sqr)) total++;
      }
    }
    writeln(M, " ", total);
  }
  writeln(total);
}