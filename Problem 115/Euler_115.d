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
  foreach (i; 0..50) previous[i] = 1;
  previous[50] = 2;
  int index = 50;
  while (previous[index] < 1_000_000) {
    if (previous.length == index + 1) previous.length += 100;
    index++;
    sum += previous[index - 51];
    previous[index] = previous[index - 1] + sum;
  }
  writeln(index);
}