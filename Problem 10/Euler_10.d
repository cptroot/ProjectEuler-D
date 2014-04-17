import std.stdio;
import std.math;
import std.algorithm;

import sieve;

void main() {
  auto primes = ShortenSieve(Sieve(2_000_000));
  writeln(reduce!((a, b) => a + b)(0L, primes));
}