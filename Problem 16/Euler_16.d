import std.stdio;
import std.bigint;
import std.conv;

void main() {
  BigInt a = "1";
  BigInt b = "2";
  foreach (v; 0..1000) {
   a *= b;
  }
  string bigInt;
  a.toString(delegate void (const (char)[] s) {bigInt = to!string(s);}, "d");
  writeln(bigInt);
  int sum = 0;
  writeln(to!int(bigInt[0]));
  foreach(c; bigInt) {
    sum += c - 48;
  }
  writeln(sum);
}