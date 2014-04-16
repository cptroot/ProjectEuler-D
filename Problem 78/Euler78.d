import std.stdio;

long numWays(int n) {
  static int[] cache = new int[2];

  if (n == 1 || n == 0) return 1;

  if (n < cache.length + 1 && cache[n - 1] != 0) return cache[n - 1];

  int k = 1;
  int pent = (3 * k - 1) * k / 2;
  
  int sum = 0;

  while (n - pent >= 0) {
    sum += numWays(n - pent) * (k % 2 == 0 ? -1 : 1);
    sum += 1_000_000;
    sum %= 1_000_000;
    k = k > 0 ? -k : -k + 1;
    pent = (3 * k - 1) * k / 2;
  }

  if (cache.length + 1 > n) cache.length = n * 2;
  cache[n - 1] = sum;

  if (sum < 0 || sum >= 1_000_000) throw new Exception("WTF?");

  return sum;
}

unittest {
  writeln("unittest");
  assert(numWays(5) == 7);
  writeln("unit test passed");
}

void main() {
  writeln(numWays(5));
  long num = 1;
  int n = 1;
  while (num != 0) {
    num = numWays(n);
    if (num < 0) throw new Exception("negative number");
    n++;
    if (n % 10_000 == 0) writeln(n);
  }
  writeln(n - 1);
}