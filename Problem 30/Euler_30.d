import std.stdio;
import std.math;
import std.conv;

void main() {
  int total = 0;
  foreach (i; 10..1_000_000) {
    int sum = 0;
    foreach (c; to!string(i)) {
      sum += pow(c - 48, 5);
    }
    if (sum == i) total += i;
  }
  writeln(total);
}