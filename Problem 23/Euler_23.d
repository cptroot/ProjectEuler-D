import std.stdio;

import sieve;
import divisor;

void main() {
  int[] sieve = ShortenSieve(Sieve(28_123));
  bool[] abundant = new bool[28_123];
  foreach (i, ref value; abundant) {
    value = SumOfDivisors(sieve, i + 1, true) > i + 1;
  }
  int total = 0;
  bool isAbundant = false;
  foreach (i; 0..28_123) {
    isAbundant = false;
    foreach (j; 0..i / 2 + 2) {
      if (abundant[j] && abundant[i - j - 1]) {
        isAbundant = true;
        break;
      }
    }
    if (!isAbundant) total += i + 1;
  }
  writeln(total);
}