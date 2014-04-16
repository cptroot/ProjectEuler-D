import std.stdio;

long numWays(int n) {
  long stored[] = new long[51];
  if (n < 3) return 1;
  if (n == 3) return 2;
  if (stored[n] != 0) return stored[n];
  long total = numWays(n - 1) + 1;
  foreach (i; 4..n + 1) {
    total += numWays(n - i);
  }
  stored[n] = total;
  return total;
}

void main() {
  long add = 0;
  long sum = 1;
  long[] previous = new long[51];
  previous[0] = 1;
  previous[1] = 1;
  previous[2] = 1;
  previous[3] = 2;
  foreach (n; 4..51) {
    sum += previous[n - 4];
    previous[n] = previous[n - 1] + sum;
  }
  writeln(previous[50]);
}