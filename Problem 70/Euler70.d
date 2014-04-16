import std.stdio;
import std.algorithm;

import sieve;
import manip;

void main() {
  int max = 1_000_000_0;
  auto sieve = Sieve(max);
  //writeln((sieve).length);
  auto totient = Totient(sieve, max);
  //writeln(totient);

  int minimumN = 0;
  double minimum_value = max;

  double value = 0;
  foreach (i; 2..max) {
    if (permutation(totient[i - 2], i)) {
      //writeln(i, " ", totient[i - 2]);
      value = cast(double)i / totient[i - 2];
      if (value < minimum_value) {
        minimumN = i;
        minimum_value = value;
      }
    }
  }

  writeln(minimumN);
}

bool permutation(size_t a, size_t b) {
  return equal(sort(toArray(a)), sort(toArray(b)));
}