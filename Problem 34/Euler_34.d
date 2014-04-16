import std.stdio;
import std.conv;
import std.math;

void main() {
  int total = 0;
  foreach (i; 10..1_000_000) {
    int value;
    int factorial = 0;
    int num = 0;
    foreach (c; to!string(i)) {
      value = c - 48;
      if (value == 0) {
        factorial = 1;
      } else {
        factorial = to!int(tgamma(value + 1));
      }
      num += factorial;
    }
    if (num == i) total += i;
  }
  writeln(total);
}