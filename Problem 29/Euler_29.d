import std.stdio;
import std.algorithm;
import std.bigInt;

void main() {
  BigInt[] values;
  BigInt value = 0;
  foreach (a; 2..101) {
    foreach (b; 2..101) {
      value = 1;
      foreach (i; 0..b) {
        value *= a;
      }
      if (!values.canFind(value)) {
        values ~= value;
      }
    }
  }
  writeln(values.length);
}