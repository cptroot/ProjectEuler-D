import std.stdio;
import std.conv;


void main() {
  long[] lengths = new long[1_000_000];
  lengths[0] = 1;
  long FindLength(long n) {
    if (n == 1) {
      return 1;
    }
    n--;
    if (lengths.length <= n) {
      n++;
      if (n % 2 == 0) {
        return FindLength(n / 2) + 1;
      }
      else {
        return FindLength(3 * n + 1) + 1;
      }
    }
    else {
      int index = to!int(n);
      if (lengths[index] != 0) {
        return lengths[index];
      }
      index++;
      n++;
      if (n % 2 == 0) {
        lengths[index - 1] = FindLength(n / 2) + 1;
      }
      else {
        lengths[index - 1] = FindLength(3 * n + 1) + 1;
      }
      return lengths[index - 1];
    }
  }
  long maxLength = 0;
  int maxNum = 1;
  for (int i = 0; i < 1_000_000; i++) {
    if (lengths.length > i)
      if (lengths[i] != 0) { continue; }
    FindLength(i + 1);
    if (maxLength < lengths[i]) {
      maxLength = lengths[i];
      maxNum = i + 1;
    }
  }
  writeln(maxNum);
  /*foreach (i, v; lengths) {
    writeln(i + 1, ": ", v);
  }*/
}