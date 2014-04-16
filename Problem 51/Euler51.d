import std.stdio;
import sieve;
import std.math;

import manip;

bool iterate(int[] iter, int max) {
  int index = cast(int)iter.length - 1;
  while (index >= 0 && iter[index] + iter.length - index == max) index--;
  if (index < 0) return false;

  iter[index]++;
  foreach (i; index+1..cast(int)iter.length) {
    iter[i] = i - index + iter[index];
  }
  return true;
}

void main() {
  immutable int digits = 6;
  immutable int max_sieve = 1_000_000;
  immutable int min_primes = 8;

  bool[] sieve = Sieve(max_sieve);
  int[] primes = ShortenSieve(sieve);
  //writeln(sieve);
  //writeln(primes);
  //writeln(primes.length);

  int[] iter = new int[digits];
  int[] nCk_iter;

  foreach (p; primes) {
    if (log10(p ) + 1 < digits) continue;
    toArray(p, digits, iter);

    //writeln(iter);

    foreach (digit; 0..10) {
      int[] locations;
      foreach (i; 0..digits) {
        if (iter[i] == digit) locations ~= i;
      }

      /*if (locations.length > 0)
        writeln(p, " ", digit, " ", locations);*/

      foreach (k; 1..cast(int)locations.length + 1) {
        nCk_iter.length = k;
        foreach (i; 0..k)
          nCk_iter[i] = i;

        int numPrimes = 1;
        int[] result_primes = [p];

        while (true) {
          numPrimes = 1;
          result_primes = [p];
          int[] iter_copy = iter.dup;

          //writeln(nCk_iter);

          foreach (d; digit + 1..10) {
            foreach (l; nCk_iter) {
              iter_copy[locations[l]] = d;
            }
            int num = toInt(iter_copy);
            if (!sieve[num - 2]) {
              numPrimes++;
              result_primes ~= num;
            }
          }

          if (numPrimes >= min_primes) {
            writeln(result_primes);
            return;
          }

          //writeln(p, " ", result_primes);

          if (!iterate(nCk_iter, k)) break;
        }
      }
    }
  }
  writeln("Nope");
}