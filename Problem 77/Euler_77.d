import std.stdio;

import sieve;

int numWays(int n, int maxIndex, int[] sieve) {
  if (n == 0) return 1;
  if (n == 1 || n < 0) return 0;
  static int[][] stored;
  if (stored.length <= n - 2) {
    stored.length = n - 1;
  }
  while(sieve[maxIndex] > n) maxIndex--;
  if (stored[n - 2].length <= maxIndex) stored[n - 2].length = maxIndex + 1;
  if (stored[n - 2][maxIndex] != 0) return stored[n - 2][maxIndex];
  int total = 0;
  foreach (i; 0..maxIndex + 1) {
    total += numWays(n - sieve[i], i, sieve);
    stored[n - 2][i] = total;
  }
  return total;
}

unittest {
  assert(numWays(10, 3, ShortenSieve(Sieve(10))) == 5);
}

void main() {
  int[] sieve = ShortenSieve(Sieve(1_000_000));
  int index = 0;
  foreach (n; 2..1_000_000) {
    if (sieve[index + 1] < n) index++;
    int result = numWays(n, index, sieve);
    if (result > 5000) {
      writeln(n);
      break;
    }
  }
}