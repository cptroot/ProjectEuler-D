import std.stdio;
import std.math;
import std.conv;
import std.algorithm;

int[] toArray(long n) {
  int length = to!int(floor(log10(n))) + 1;
  int[] result = new int[length];
  foreach (i; 0..length) {
    result[$ - i - 1] = n % 10;
    n -= result[$ - i - 1];
    n /= 10;
  }
  return result;
}

void main() {
  int[long] associative;
  long[long] associativeResult;
  foreach (n; 1L..10000L) {
    long cube = n * n * n;
    auto array = toArray(cube);
    sort!("b < a")(array);
    long key = 0;
    foreach (v; array) {
      key *= 10;
      key += v;
    }
    //writeln(cube, " ", array, " ", key);
    associative[key]++;
    if (key !in associativeResult)
      associativeResult[key] = cube;
    if (associative[key] == 5) {
      writeln(key, " ", associativeResult[key]);
      break;
    }
  }
}