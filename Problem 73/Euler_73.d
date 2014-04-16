import std.stdio;
import std.math;
import std.typecons;

import sieve;
import divisor;

void main() {
  int total = 0;
  auto temp = SieveHash(12_000);
  auto sieve = ShortenSieve(temp[0]);
  auto hash = temp[1];
  writeln("Done sieve");
  foreach (d; 2..12_001) {
    auto divisors = Divisors(sieve, hash, d);
    int maxn = cast(int)ceil(cast(real)(1 * d) / cast(real) 2);
    int minn = cast(int)floor(cast(real)(1 * d) / cast(real) 3);
    int[] Ndivisors;
    bool share = true;
    foreach (n; minn + 1..maxn) {
      if (n < 2) continue;
      Ndivisors = Divisors(sieve, hash, n);
      share = false;
      foreach (i, divisor; divisors) {
        if (divisor == 0) continue;
        if (Ndivisors[i] == 0) continue;
        share = true;
        break;
      }
      if (!share) total++;
    }
    if (d % 100 == 0) writeln(d);
  }
  writeln(total);
}