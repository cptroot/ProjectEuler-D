import std.stdio;
import std.math;
import std.conv;

void main() {
  uint[8] iterator = [0, 0, 0, 0, 0, 0, 0, 0];
  ulong current;
  foreach (_; 0..100_000_000) {
    current = 10203040506070809UL;
    current += iterator[0] * 1000_000_000_000_000UL;
    current += iterator[1] * 10_000_000_000_000UL;
    current += iterator[2] * 100_000_000_000UL;
    current += iterator[3] * 1000_000_000UL;
    current += iterator[4] * 10_000_000UL;
    current += iterator[5] * 100_000UL;
    current += iterator[6] * 1000UL;
    current += iterator[7] * 10UL;

    if (floor(sqrt(current)) == sqrt(current)) {writeln(to!long(sqrt(current))); break;}

    iterator[0]++;
    foreach (i; 0..7) {
      if (iterator[i] == 10) {
        iterator[i] = 0;
        iterator[i + 1]++;
      }
    }
  }
}