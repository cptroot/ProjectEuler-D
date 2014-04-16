import std.stdio;

void main() {
  int[] values = new int[1001];
  foreach (a; 1..334) {
    foreach (b; a + 1..(1000 - a - 1) / 2 + 1) {
      foreach (c; b + 1..(1000 - a - b) + 1) {
        if (c * c == a * a + b * b) {
          values[a + b + c]++;
        }
      }
    }
  }
  int max;
  int maxValue;
  foreach (i, value; values) {
    if (value > maxValue) {
      max = i;
      maxValue = value;
    }
  }
  writeln(max);
}