import std.stdio;
import std.math;
import std.conv;
import std.bigint;

int length(BigInt num){
  string s;
  num.toString((const(char)[] str) {s = to!string(str);}, "d");
  return s.length;
}

void main() {
  BigInt num = 3;
  BigInt den = 2;
  int total = 0;
  foreach (i; 0..1_000) {
    if (length(num) > length(den)) total++;
    num += den;
    BigInt temp = num;
    num = den;
    den = temp;
    num += den;
    if (num < 0) throw new Exception("numerator is negative");
  }
  writeln(total);
}