import std.stdio;
import std.math;
import std.typecons;
import std.algorithm;
import std.conv;

import divisor;
import sieve;

int primePowerSum(int[] sieve, int i, int n) {
  static int[][] stored;
  if (n == 0) return 1;
  if (i >= stored.length) stored.length = i + 5;
  if (n >= stored[i].length) stored[i].length = n + 5;
  if (stored[i][n] != 0) return stored[i][n];
  int result = primePowerSum(sieve, i, n - 1);
  result += pow(sieve[i], n);
  stored[i][n] = result;
  return result;
}

int properSum(int[] sieve, int n, int[] divisors) {
  int total = 1;
  foreach (i, v; divisors) {
    if (v == 0) continue;
    total *= primePowerSum(sieve, i, v);
  }
  return total - n;
}

Tuple!(int, int) getMin(int[] sieve, int[] hash, int n, Tuple!(int, int)[] numbers, int[] previous) {
  if (n < numbers.length && numbers[n][0] != 0) return numbers[n];
  if (n == 0) return tuple(-1, -1);
  previous ~= n;
  int value = properSum(sieve, n, Divisors(sieve, hash, n));
  if (value > 1_000_000) return tuple(-1, -1);
  int result = countUntil(previous, value);
  //writeln(n, " ", value, " ", previous, " ", result);
  if (result != -1) {
    return tuple(to!int(previous.length) - result, previous[result]);
  }
  numbers[n] = getMin(sieve, hash, value, numbers, previous);
  
  return numbers[n];
}

void main() {
  Tuple!(bool[], int[]) temp = SieveHash(1_000_000);
  int[] sieve = ShortenSieve(temp[0]);
  int[] hash = temp[1];
  int[] next;
  int maxLength = 0;
  int maxValue = 0;
  writeln(properSum(sieve, 28, Divisors(sieve, hash, 28)));
  Tuple!(int, int)[] numbers = new Tuple!(int, int)[1_000_005];
  foreach (n; 2..1_000_001) {
    if (n % 1000 == 0) writeln(n);
    if (!temp[0][n - 2]) { numbers[n] = tuple(-1, -1); continue; }
    auto result = getMin(sieve, hash, n, numbers, []);
    if (result[0] > maxLength) {
      maxLength = result[0];
      maxValue = result[1];
    }
  }
  writeln(maxValue);
}
