import std.stdio;

void main() {
  long lastDigits;
  foreach (i; 1..1001) {
    long value = 1;
    foreach (j; 0..i) {
      value *= i;
      value %= 10_000_000_000;
    }
    lastDigits += value;
    lastDigits %= 10_000_000_000;
  }
  writeln(lastDigits);
}