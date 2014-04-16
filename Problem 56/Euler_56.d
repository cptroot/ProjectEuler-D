import std.stdio;
import std.bigint;
import std.conv;

int sumOfDigits(BigInt num) {
  int total = 0;
  string s;
  num.toString((const(char)[] str) {s = to!string(str);}, "d");
  foreach (c; s) {
    total += c - 48;
  }
  return total;
}

void main() {
  int maxSum;
  foreach (i; 2..100) {
    BigInt a = i;
    BigInt m = i;
    foreach (x; 0..100) {
      int sum = sumOfDigits(a);
      if (sum > maxSum) maxSum = sum;
      a *= m;
    }
  }
  writeln(maxSum);
}