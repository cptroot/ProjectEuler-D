import std.stdio;
import std.math;

void main() {
  int n = 1;
  int total;
  int min = 1;
  while (floor(log10(pow(cast(float)9, cast(float)n))) == n - 1) {
    foreach (i; min..10) {
      if (floor(log10(pow(cast(float)i, cast(float)n))) == n - 1) {
        total++;
        writeln(n, " ", i);
      }
      else min = i + 1;
    }
    n++;
  }
  writeln(total);
}