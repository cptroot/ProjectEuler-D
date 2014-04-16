import std.stdio;
import std.algorithm;

import sieve;

void main() {
  long rem = 0;
  uint index = 9590;
  int[] sieve = ShortenSieve(Sieve(10_000_00));

  writeln(sieve[0]);

  writeln("sieve finished");
  while (rem <= 10_000_000_000L) {
    index += 2;
    if (index >= sieve.length) throw new Exception("NOPE");
    rem = (2 * index + 2) % sieve[index];
    rem *= sieve[index];
  }
  writeln(index + 1, " ", sieve[index]);
}