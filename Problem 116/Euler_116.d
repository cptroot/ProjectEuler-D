import std.stdio;
import std.bigint;

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
  long[51][3] previous;
  foreach (tileLength; 2..5) {
    foreach (i; 0..tileLength) previous[tileLength - 2][i] = 1;
    previous[tileLength - 2][tileLength] = 2;
    foreach (n; tileLength + 1..51) {
      previous[tileLength - 2][n] = previous[tileLength - 2][n - 1] + previous[tileLength - 2][n - tileLength];
    }
  }
  writeln(previous[0][50] + previous[1][50] + previous[2][50] - 3);
}