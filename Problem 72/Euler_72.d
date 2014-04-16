import std.stdio;
import std.conv;
import std.algorithm;
import std.math;

import sieve;
import divisor;

int phi(int[] sieve, int[] factors, int n) {
  static int[][] stored;
  int[] reduced;
  foreach (i, value; factors) {
    if (value > 0) {
      reduced ~= i;
    }
  }
  int numPrimes = reduced.length;
  int[] iterator;
  iterator.length = reduced.length;
  iterator[] = 0;
  int phi = 1;
  foreach (i; reduced) {
    if (factors[i] - 1 >= 1) {
      if (stored.length <= i) {
        stored.length = i+1000;
      }
      if (stored[i].length < factors[i]) {
        stored[i].length = factors[i] + 1000;
      }
      if (stored[i][factors[i] - 2] == 0) {
        stored[i][factors[i] - 2] = pow(sieve[i], factors[i] - 1) * (sieve[i] - 1);
      }
      phi *= stored[i][factors[i] - 2];
    }
    else {
      phi *= (sieve[i] - 1);
    }
  }
  return phi;
}

unittest {
  int[] sieve = ShortenSieve(Sieve(100000));
  assert(phi(sieve, Divisors(sieve, 4), 4) == 2);
  assert(phi(sieve, Divisors(sieve, 6), 6) == 2);
  assert(phi(sieve, Divisors(sieve, 10), 10) == 4);
  writeln("unit test successful");
}

void main() {
  int[] shortSieve = ShortenSieve(Sieve(1000000));
  writeln("Finished sieve");
  long sum = 0;
  int count = 0;
  foreach (n; 2..1000001) {
    int[] divisors = Divisors(shortSieve, n);
    int phi = phi(shortSieve, divisors, n);
    sum += phi;
    count++;
    if (count == 1000) {
      count = 0;
      writeln(n);
    }
    if (sum < 0) throw new Exception("negative number");
  }
  writeln(sum);
}