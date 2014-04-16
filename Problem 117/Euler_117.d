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
  long[51] previous;
  previous[0] = 1;
  previous[1] = 1;
  previous[2] = 2;
  previous[3] = 4;
  foreach (n; 4..51) {
    previous[n] = previous[n - 1] + previous[n - 2] + previous[n - 3] + previous[n - 4];
  }
  writeln(previous[50]);
}