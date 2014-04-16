import std.stdio;
import std.bigint;
import std.conv;

void main() {
  BigInt x = 1;
  foreach (i; 1..101) {
    x *= BigInt(i);
  }
  string bigInt;
  x.toString(delegate void (const (char)[] s) {bigInt = to!string(s);}, "d");
  int sum = 0;
  foreach (c; bigInt) {
    sum += c - 48;
  }
  writeln(sum);
}