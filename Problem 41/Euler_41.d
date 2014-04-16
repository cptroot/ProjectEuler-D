import std.stdio;
import std.conv;
import std.math;
import std.algorithm;

import sieve;

bool isPandigital(string number, int n) {
  if (number.length != n) return false;
  static bool[] hasDigit;
  hasDigit = null;
  hasDigit.length = n;
  hasDigit[] = false;
  foreach (c; number) {
    if (c != '0' && c < n + 49) hasDigit[c - 49] = true;
  }
  return reduce!( (a, b) { return a & b;})(true, hasDigit);
}

bool isPrime(int i, bool[] sieve) {
  int divisor = 2;
  auto sqrtLimit = sqrt(i);
  while (divisor < sqrtLimit) {
    if (sieve[divisor - 2]) {
      divisor++;
      continue;
    }
    if (i % divisor == 0) {
      return false;
    }
    divisor++;
  }
  return true;
}

void main() {
  bool[] sieve = Sieve(1_000_000);
  bool written = false;
  for (int i = 7_654_321; i > 1_000_000; i--) {
    if (!written) {
      written = true;
    }
    if (isPandigital(to!string(i), 7)) {
      writeln(i);
      if (i % 2 == 1 && isPrime(i, sieve)) {
        writeln(i);
        return;
      }
    }
  }
}