import std.stdio;
import std.math;
import std.conv;

void main() {
  int[] remaining = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9];
  int sum = 1_000_000 - 1;
  int place = 0;
  int index = 0;
  long result = 0;
  while (place != 10) {
    index = 0;
    long factorial = 1;
    if (remaining.length > 0)
      factorial = to!long(tgamma(remaining.length));
    writeln(factorial, " ", sum, " ", remaining.length);
    while (sum >= factorial) {
      sum -= factorial;
      index++;
    }
    writeln(index);
    result *= 10;
    result += remaining[index];
    remaining = remaining[0..index] ~ remaining[(index + 1)..$];
    place++;
  }
  writeln(result);
}