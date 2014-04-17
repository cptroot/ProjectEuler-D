import std.stdio;
import std.math;

import sieve;

void main() {
  auto primes = ShortenSieve(Sieve(1_000_000));
  auto total = 0;
  int i = 0;
  while (i < primes.length && total < 10_000) {
    i++;
    total++;
  }
  writeln(primes[i]);
}