import std.stdio;
import std.conv;
import std.math;
import std.algorithm;

int[] toArray(int i) {
  int length = to!int(floor(log10(i))) + 1;
  int temp = i;
  int[] num = [];
  foreach (j; 0..length) {
    num ~= temp%10;
    temp -= num[j];
    temp /= 10;
  }
  return num;
}

bool sameContents(int[] a, int[] b) {
  if (a.length != b.length) return false;
  int[] c = a.dup;
  foreach (v;b) {
    int i = -1;
    if ((i = countUntil(c, v)) == -1) return false;
    c = c[0..i] ~ c[i + 1..$];
  }
  return true;
}

unittest {
  assert(toArray(10) == [0, 1]);
  assert(sameContents([0, 1], [1, 0]));
  assert(sameContents([0, 1, 1, 2], [2, 1, 0, 1]));
}

void main() {
  foreach (i; 10..1_000_000) {
    int[] numbers = toArray(i);
    bool good = true;
    foreach (n; 2..7) {
      if (!sameContents(numbers, toArray(i * n))) {
        good = false;
        break;
      }
    }
    if (good) {
      writeln(i);
      return ;
    }
  }
}