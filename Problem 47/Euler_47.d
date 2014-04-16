import std.stdio;
import std.algorithm;

import sieve;
import divisor;

int NumDivisors(int[] divisors) {
  return reduce!( (a, b) { if (b > 0) return a + 1; return a;})(0, divisors);
}

void main() {
  int limit = 1000000;
  int[] sieve = DivisorSieve(limit);
  /*foreach (i, value; sieve) {
    writeln(i + 2, ": ", value);
  }*/
  int i = 640;
  while (i < limit) {
    //writeln(i);
    if (sieve[i - 2] == 0) {
      i += 4;
      continue;
    }
    int num = sieve[i - 2];
    if (num == 4) {
      bool moreThan4 = true;
      for (int j = -1; j > -4; j--) {
        if (sieve[i + j - 2] != 4) {
          moreThan4 = false;
          i += j + 4;
          break;
        }
      }
      if (moreThan4) {
        writeln(i - 3);
        return;
      }
    }
    else i += 4;
  }
  writeln("Not yet.");
}