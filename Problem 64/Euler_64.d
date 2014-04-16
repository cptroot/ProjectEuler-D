import std.stdio;
import std.math;
import std.conv;
import std.algorithm;
import std.typecons;

void main() {
  int total = 0;
  int max = 10001;
  //auto tempSieve = SieveHash(max);
  //int[] sieve = ShortenSieve(tempSieve[0]);
  //int[] hash = tempSieve[1];
  foreach (n; 2..max) {
    if (sqrt(n) == floor(sqrt(n))) continue;
    int maxInt = to!int(floor(sqrt(n))) + 1;
    Tuple!(int, int)[] previous = [];
    Tuple!(int, int) current = tuple(maxInt - 1, 1);
    int next;
    while (!canFind(previous, current)) {
      previous ~= current;
      int top = current[1];
      int bottom = n - current[0] * current[0];
      if (bottom % top != 0) throw new Exception("WTF?");
      bottom /= top;
      top = -current[0];
      next = 0;
      current = tuple(top, bottom);
      while ((next + 1) * current[1] + top < maxInt) {
        next++;
      }
      current[0] += next * current[1];
    }
    if (previous.length % 2 == 1) total++;
  }
  writeln(total);
}