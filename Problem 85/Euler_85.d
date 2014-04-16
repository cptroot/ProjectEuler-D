import std.stdio;

void main() {
  int k = 2000;
  int min = 2_000_000;
  int result = 0;
  foreach (j; 1..54) {
    int valueM = k * (k + 1) * j * (j + 1) / 4;
    while (valueM > 2_000_000) {
      k--;
      valueM = k * (k + 1) * j * (j + 1) / 4;
    }
    if (2_000_000 - valueM < min) {
      min = 2_000_000 - valueM;
      result = k * j;
    }
    int valuem = (k + 1) * (k + 2) * j * (j + 1) / 4;
    if (valuem - 2_000_000 < min) {
      min = valuem - 2_000_000;
      result = (k + 1) * j;
    }
  }
  writeln(result);
}
    