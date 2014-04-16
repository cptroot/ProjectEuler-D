import std.stdio;
import std.algorithm;
import std.conv;

bool isPentagonal(long num) {
  static long max;
  static bool init = false;
  if (!init) {
    init = true;
    max = pentagons[998];
    writeln(max);
    readln();
  }
  if (num > max) {
    foreach (long i; pentagons.length..pentagons.length + 1_000) {
      pentagons ~= i * (3 * i - 1) / 2;
      if (pentagons[to!uint(i) - 1] < 0) {
        writeln(i - 1);
        readln();
      }
    }
    max = pentagons[$ - 1];
  }
  return pentagons.canFind(num);
}

int minIndex(long[] arr) {
  static int min = 0;
  static long minValue = 0;
  min = 0;
  minValue = arr[0];
  foreach (i, value; arr) {
    if (minValue > value) {
      min = i;
      minValue = value;
    }
  }
  return min;
}

void main() {
  int[] n = [1];
  int[] diffs = [4];
  long[] pentagons;
  foreach (long i; 1..1_000) {
    pentagons ~= i * (3 * i - 1) / 2;
    if (pentagons[to!uint(i) - 1] < 0) {
      writeln(i - 1);
      readln();
    }
  }
  
  foreach(d; 
    