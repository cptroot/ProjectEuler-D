import std.stdio;
import std.math;
import std.algorithm;

import sieve;
import divisor;

void main() {
  int[] primes = ShortenSieve(Sieve(1_000_000));
  int maxDivisors = 0;
  int i = 0;
  for (i = 1; i < 1_000_000 && maxDivisors < 500; i++) {
    int num = i * (i + 1) / 2;
    int divisors = NumDivisors(primes, num);
    if (maxDivisors < divisors) {
      maxDivisors = divisors;
    }
  }
  writeln(i * (i - 1) / 2);
}