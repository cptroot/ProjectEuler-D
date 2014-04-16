import std.stdio;
import std.math;
import std.conv;
import std.algorithm;

import sieve;

bool isPermutation(int a, int b) {
  const auto aInit = a;
  const auto bInit = b;
  int[] aArray;
  aArray.length = to!int(floor(log10(a))) + 1;
  for (int i = 0; i < aArray.length; i++) {
    aArray[$ - i - 1] = a % 10;
    a -= aArray[$ - i - 1];
    a /= 10;
  }
  int length = aArray.length;
  for (int i = 0; i < length; i++) {
    int num = b % 10;
    int index = aArray.countUntil(num);
    if (index == -1) return false;
    aArray = aArray[0..index] ~ aArray[index + 1..$];
    b -= num;
    b /= 10;
  }
  return true;
}

void main() {
  bool[] sieve = Sieve(10_000);
  int[] shortSieve = ShortenSieve(sieve);
  foreach (i; shortSieve) {
    if (i < 1488) continue;
    foreach (j; 2..(10000 - i) / 2) {
      if (sieve[i + j - 2] || sieve[i + j + j - 2]) continue;
      if (isPermutation(i, i + j) && isPermutation(i, i + j + j)) {
        writeln(i, i + j, i + j + j);
        return;
      }
    }
  }
}