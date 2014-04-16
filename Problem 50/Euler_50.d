import std.stdio;
import std.algorithm;

import sieve;

void main() {
  int[] sieve = ShortenSieve(Sieve(1_000_000));
  for (int length = 546; length > 0; length--) {
    foreach (offset; 0..547 - length) {
      int total = 0;
      foreach (i; offset..offset + length + 1) {
        total += sieve[i];
      }
      if (!sieve.canFind(total)) continue;
      writeln(total);
      return;
    }
  }
}