import std.stdio;
import std.math;
import std.conv;

import sieve;

void main() {
  auto primes = ShortenSieve(Sieve(1_000_000));
  long input = 600851475143;
  auto sqrtInput = sqrt(to!float(input));
  long lastPrime = input;
  foreach (p; primes) {
    if (input == 1) break;
    if (p > sqrtInput) {
      writeln(input);
      return;
    }
    while (input % p == 0) {
      input /= p;
      lastPrime = p;
    }
  }
  writeln(lastPrime);
}