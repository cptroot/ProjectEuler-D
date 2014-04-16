import std.stdio;
import std.math;
import std.conv;
import std.algorithm;

import sieve;

bool isPrime(int[] shortsieve, bool[] sieve, long a) {
  real rt = sqrt(a);
  bool prime = true;
  for (int j = 0; shortsieve[j] < rt; j++) {
    if (a % shortsieve[j] == 0) {
      prime = false;
      break;
    }
  }
  return prime;
}

int[][] findK(int[][int] pairs) {
  int[][] result;
  foreach (a, l1; pairs) {
    foreach (b, l2; pairs) {
      if (a > b) continue;
      if (!canFind(pairs[b], a)) continue;
      foreach (c, l3; pairs) {
        if (a > c || b > c) continue;
        if (!canFind(pairs[c], a) || !canFind(pairs[c], b)) continue;
        //writeln(a, " ", b, " ", c);
        //result ~= [a, b, c];
        foreach (d, l4; pairs) {
          if (a > d || b > d || c > d) continue;
          if (!canFind(pairs[d], a) ||
            !canFind(pairs[d], b) ||
            !canFind(pairs[d], c)) continue;
          result ~= [a, b, c, d];
          //break;
        }
        //if (result != []) break;
      }
        //if (result != []) break;
    }
        //if (result != []) break;
  }
  return result;
}
  

void main() {
  int min = 50083;
  int[] minOverall = [];
  int limit = 3_000_000;
  auto sieve = Sieve(limit);
  writeln(sieve.length);
  auto shortsieve = ShortenSieve(sieve);
  int[][int] pairs;
  foreach (index, n; shortsieve) {
    if (index % 100 == 0) writeln(n);
    int length = to!int(floor(log10(n))) + 1;
    int lengthm;
    for (int j = 0; shortsieve[j] < n; j++) {
      int m = shortsieve[j];
      lengthm = to!int(floor(log10(m))) + 1;
      ulong a = m * pow(10, length) + n;
      if (a < 0) throw new Exception("WTF?");
      if (a < limit - 1 && sieve[to!uint(a) - 2]) continue;
      if (a >= limit - 1 && !isPrime(shortsieve, sieve, a)) continue;
      
      a = n * pow(10, lengthm) + m;
      if (a < 0) throw new Exception("WTF?");
      if (a < limit - 1 && sieve[to!uint(a) - 2]) continue;
      if (a >= limit - 1 && !isPrime(shortsieve, sieve, a)) continue;
      //writeln(n, " ", m, " ", a);
      pairs[n] ~= m;
      pairs[m] ~= n;
    }
    if (n in pairs && pairs[n].length >= 4) {
      int[][int] limitedPairs;
      int numhelpers = pairs[n].length;
      foreach (k; pairs[n]) {
        int numpairs = pairs[n].length;
        foreach (l; pairs[n]) {
          if (k == l) continue;
          if (!canFind(pairs[k], l)) numpairs--;
          else limitedPairs[k] ~= l;
          if (numpairs < 4) {
            numhelpers--;
            break;
          }
        }
      }
        if (numhelpers < 4) {
          //writeln(n, pairs[n]);
          foreach (index, v; limitedPairs) {
            //writeln(index, ": ", v);
          }
          //writeln();
        }
      
      if (numhelpers >= 4) {
        int[][] results = findK(limitedPairs);
        //writeln(n, pairs[n]);
        foreach (index, v; limitedPairs) {
          //writeln(index, ": ", v);
        }
        int minSum = 50083;
        int[] minResult;
        foreach (result; results) {
          int sum = reduce!("a + b")(0, result);
          if (sum < minSum) {
            minSum = sum;
            minResult = result;
          }
        }
        //writeln(minResult, " ", minSum + n, " ", n);
        if (minSum + n < min) {
          min = minSum + n;
          minOverall = minResult;
          writeln(minResult, " ", minSum + n, " ", n);
        }
        //if (results != []) break;
        if (n >= min) break;
      }
    }
  }
  int max = 0;
  foreach (i, v; pairs) {
    if (i > max) max = i;
  }
  //writeln(max, ": ", pairs[max]);
}