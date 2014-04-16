import std.stdio;

long numWays(int n, int max) {
  static long[][] previous;
  if (n == 1 || n == 0) return 1;
  if (max > n) max = n;
  if (n >= previous.length) {
    previous.length = n + 1;
  }
  if (max >= previous[n].length) {
    previous[n].length = max + 1;
  }
  if (previous[n][max] != 0) return previous[n][max];
  long sum = 0;
  for (int i = max; i > 0; i--) {
    sum += numWays(n - i, i);
  }
  previous[n][max] = sum;
  return sum;
}

unittest {
  writeln("unittest");
  assert(numWays(5, 5) == 7);
  writeln("unit test passed");
}

void main() {
  writeln(numWays(100, 100) - 1);
}