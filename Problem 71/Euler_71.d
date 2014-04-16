import std.stdio;
import std.math;
import std.typecons;

import sieve;
import divisor;

void main() {
  auto frac = tuple(0, 1);
  int[] sieve = ShortenSieve(Sieve(1_000_000));
  writeln("Done sieve");
  foreach (d; 2..1_000_001) {
    auto divisors = Divisors(sieve, d);
    int n = cast(int)ceil(cast(real)(3 * d) / cast(real) 7);
    int[] Ndivisors;
    bool share = true;
    do {
      if (n < 2) break;
      n--;
      if (frac[0] * d > n * frac[1]) break;
      Ndivisors = Divisors(sieve, n);
      share = false;
      foreach (i, divisor; divisors) {
        if (divisor == 0) continue;
        if (Ndivisors[i] == 0) continue;
        share = true;
        break;
      }
    } while (share && n > 2)
    if (frac[0] * d < n * frac[1] && !share) {
      frac = tuple(n, d);
    }
    if (d % 10000 == 0) writeln(frac);
  }
  writeln(frac[0]);
}