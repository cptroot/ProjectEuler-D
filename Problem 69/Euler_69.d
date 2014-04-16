import std.stdio;
import std.conv;
import std.algorithm;
import std.math;

import sieve;
import divisor;

int phi(int[] sieve, int[] factors, int n) {
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
    phi *= pow(sieve[i], factors[i] - 1) * (sieve[i] - 1);
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
  double max = 1;
  int maxNum = 1;
  foreach (n; 2..1000001) {
    int[] divisors = Divisors(shortSieve, n);
    int phi = phi(shortSieve, divisors, n);
    double division = to!double(n) / to!double(phi);
    if (division < max) continue;
    max = division;
    maxNum = n;
    writeln(max, " ", maxNum);
  }
  writeln(maxNum);
}