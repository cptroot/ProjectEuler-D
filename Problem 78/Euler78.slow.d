import std.stdio;

long numWays(int n) {
  int max = n;
  static long[] maxs = [1];
  static uint maxsLength = 1;
  static long[][] previous;
  static uint offset = 0;
  static uint stored = 0;
  if (n == 1 || n == 0) return 1;
  while (maxs.length <= n) maxs.length += 1000;
  while (maxsLength <= n) {
    int i = previous.length + offset;
    long[] temp = [0];
    temp.length = (i + 1) / 2 + 1;
    foreach (j; 1..(i + 1) / 2 + 1) {
      if ((i - j + 1) / 2 >= j) {
        temp[j] = previous[i - 1 - offset][j - 1] + previous[i - j - offset][j];
      }
      else {
        temp[j] = previous[i - 1 - offset][j - 1] + maxs[i - j * 2 + 1];
      }
      temp[j] %= 1000000;
      if (i + 1 == j * 2) {
        maxs[maxsLength] = temp[j];
        maxsLength++;
        stored++;
        if (stored == 100) {
          offset += 100;
          previous = previous[100..$];
          stored = 0;
        }
      }
    }
    previous ~= temp;
  }
  return maxs[n];
}

unittest {
  writeln("unittest");
  assert(numWays(5) == 7);
  writeln("unit test passed");
}

void main() {
  long num = 1;
  int n = 1;
  while (num % 1000000 != 0) {
    num = numWays(n);
    if (num < 0) throw new Exception("negative number");
    n++;
    if (n % 100 == 0) writeln(n);
  }
  writeln(n);
}