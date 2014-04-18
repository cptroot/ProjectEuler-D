import std.stdio;
import std.math;
import std.algorithm;

import sieve;
import divisor;

void main() {
  auto sieve = ShortenSieve(Sieve(10_000));
  int[] divisors = new int[10_000];
  int total = 0;
  foreach (i, ref value; divisors) {
    value = SumOfDivisors(sieve, i + 1);
    if (value - 1 < 10_000) {
      if (divisors[value - 1] == i + 1 && value != i + 1) {
        total += value;
        total += i + 1;
        writeln(value, " ", i+1);
      }
    }
  }
  writeln(total);
}