import std.stdio;
import std.math;
import std.typecons;
import std.conv;

import sieve;
import divisor;

int NumberFromDivisor(int[] divisor, int[] sieve) {
  int result = 1;
  foreach (i, value; divisor) {
    result *= pow(sieve[i], value);
  }
  return result;
}

Tuple!(int, int) ReduceFraction(int num, int den, int[] sieve) {
  if (num == 0) return tuple(0, 1);
  if (den == 0) return tuple(1, 0);
  auto numDivisors = Divisors(sieve, num);
  auto denDivisors = Divisors(sieve, den);
  foreach (i, value; numDivisors) {
    if (value == 0) continue;
    if (denDivisors[i] == 0) continue;
    int minimum = value < denDivisors[i] ? value: denDivisors[i];
    numDivisors[i] -= minimum;
    denDivisors[i] -= minimum;
  }
  return tuple(NumberFromDivisor(numDivisors, sieve), NumberFromDivisor(denDivisors, sieve));
}

void main() {
  auto sieve = ShortenSieve(Sieve(100));
  int top = 1;
  int bottom = 1;
  foreach(den; 10..100) {
    foreach(num; 10..den) {
      auto reduced = ReduceFraction(num, den, sieve);
      if (den / 10 == num % 10) {
        if (reduced == ReduceFraction(num / 10, den % 10, sieve)) {
          top *= num;
          bottom *= den;
          writeln(num, " / ", den);
        }
      }
      if (den % 10 == num / 10) {
        if (reduced == ReduceFraction(num % 10, den / 10, sieve)) {
          top *= num;
          bottom *= den;
          writeln(num, " / ", den);
        }
      }
    }
  }
  writeln(ReduceFraction(top, bottom, sieve)[1]);
}