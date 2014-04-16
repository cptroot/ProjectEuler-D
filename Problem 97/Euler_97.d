import std.stdio;

void main() {
  long rem = 1;
  foreach (i; 0..7830457) {
    rem *= 2;
    rem %= 10000000000;
  }
  rem *= 28433;
  rem %= 10000000000;
  rem++;
  writeln(rem);
}