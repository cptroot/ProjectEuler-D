import std.stdio;
import std.algorithm;
import std.bigint;

import sieve;

int gcd(int a, int b) {
  int temp;
  while (b != 0) {
    temp = b;
    b = a % b;
    a = temp;
  }
  return a;
}

void main() {
  int limit = 100_000_000;

  bool[] sieve = Sieve(limit);

  BigInt total = limit / 2 + limit - 2;
  foreach (n; 3..limit / 2 + 1) {
    bool prime = false;
    long temp = 0;
    if (n % 2 == 1 && !sieve[(n - 3) / 2]) prime = true;
    foreach (x; 1..(n + 1) / 2) {
      if (x == 1 || prime) {
        temp += 2 * (limit / n - 1);
        if (gcd(x, n - x) != 1) writeln(n, " ", x);
        continue;
      }
      if (gcd(x, n - x) != 1) continue;
      temp += 2 * (limit / n - 1);
    }
    if (temp < 0) throw new Exception("negative number");
    total += temp;
    if (n % 1000 == 0) writeln(n);
  }
  writeln(limit, " ", total * BigInt(6));
}