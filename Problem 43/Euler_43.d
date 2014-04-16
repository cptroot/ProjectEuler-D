import std.stdio;
import std.algorithm;
import std.conv;

void main() {
  int[] remaining = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9];
  long total = 0;
  foreach (i1; 1..10) {
    long d1 = i1;
    remaining = remaining[0..i1] ~ remaining[i1 + 1..$];
    foreach (i2; 0..9) {
      long d2 = remaining[i2];
      remaining = remaining[0..i2] ~ remaining[i2 + 1..$];
      foreach (i3; 0..8) {
        long d3 = remaining[i3];
        remaining = remaining[0..i3] ~ remaining[i3 + 1..$];
        foreach (i4; 0..7) {
          long d4 = remaining[i4];
          if ((d2 * 100 + d3 * 10 + d4) % 2 != 0) continue;
          remaining = remaining[0..i4] ~ remaining[i4 + 1..$];
          foreach (i5; 0..6) {
            long d5 = remaining[i5];
            if ((d3 * 100 + d4 * 10 + d5) % 3 != 0) continue;
            remaining = remaining[0..i5] ~ remaining[i5 + 1..$];
            foreach (i6; 0..5) {
              long d6 = remaining[i6];
              if ((d4 * 100 + d5 * 10 + d6) % 5 != 0) continue;
              remaining = remaining[0..i6] ~ remaining[i6 + 1..$];
              foreach (i7; 0..4) {
                long d7 = remaining[i7];
                if ((d5 * 100 + d6 * 10 + d7) % 7 != 0) continue;
                remaining = remaining[0..i7] ~ remaining[i7 + 1..$];
                foreach (i8; 0..3) {
                  if (remaining.length != 3) writeln(d1, d2, d3, d4, d5, d6, d7);
                  long d8 = remaining[i8];
                  if ((d6 * 100 + d7 * 10 + d8) % 11 != 0) continue;
                  remaining = remaining[0..i8] ~ remaining[i8 + 1..$];
                  foreach (i9; 0..2) {
                    long d9 = remaining[i9];
                    if ((d7 * 100 + d8 * 10 + d9) % 13 != 0) continue;
                    remaining = remaining[0..i9] ~ remaining[i9 + 1..$];
                    long d10 = remaining[0];
                    if ((d8 * 100 + d9 * 10 + d10) % 17 != 0) {
                      remaining = remaining[0..i9] ~ to!int(d9) ~ remaining[i9..$];
                      continue;
                    }
                    long num = d1 * 1000000000 + d2 * 100000000 + d3 * 10000000 + d4 * 1000000 + d5 * 100000 + d6 * 10000 + d7 * 1000 + d8 * 100 + d9 * 10 + d10;
                    writeln(num);
                    total += d1 * 1000000000 + d2 * 100000000 + d3 * 10000000 + d4 * 1000000 + d5 * 100000 + d6 * 10000 + d7 * 1000 + d8 * 100 + d9 * 10 + d10;
                    remaining = remaining[0..i9] ~ to!int(d9) ~ remaining[i9..$];
                  }
                  remaining = remaining[0..i8] ~ to!int(d8) ~ remaining[i8..$];
                }
                remaining = remaining[0..i7] ~ to!int(d7) ~ remaining[i7..$];
              }
              remaining = remaining[0..i6] ~ to!int(d6) ~ remaining[i6..$];
            }
            remaining = remaining[0..i5] ~ to!int(d5) ~ remaining[i5..$];
          }
          remaining = remaining[0..i4] ~ to!int(d4) ~ remaining[i4..$];
        }
        remaining = remaining[0..i3] ~ to!int(d3) ~ remaining[i3..$];
      }
      remaining = remaining[0..i2] ~ to!int(d2) ~ remaining[i2..$];
    }
    remaining = remaining[0..i1] ~ to!int(d1) ~ remaining[i1..$];
  }
  writeln(total);
}
