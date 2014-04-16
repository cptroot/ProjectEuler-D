import std.stdio;
import std.typecons;

import sieve;
import divisor;
import rbtree;

void main() {
  auto sieve = SieveHash(100001);
  int[] shortSieve = ShortenSieve(sieve[0]);
  int[] hash = sieve[1];
  auto tree = new RBTree!((a, b) {if (a[1] == b[1]) return a[0] < b[0]; return a[1] < b[1];}, Tuple!(int, int))(tuple(1, 1));
  foreach (i; 2..100001) {
    int[] divisors = Divisors(shortSieve, hash, i);
    int num = 1;
    foreach (j, v; divisors) {
      if (v > 0) num *= shortSieve[j];
    }
    tree.insert(tuple(i, num));
    if (i % 100 == 0) writeln(i);
  }
  int index = 1;
  Tuple!(int, int) value;
  foreach (v; tree) {
    if (index == 10000) {
      value = v;
      break;
    }
    index++;
  }
  writeln(value[0]);
}