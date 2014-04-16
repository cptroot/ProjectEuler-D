import std.stdio;
import std.bigint;

void main() {
  string maxIntString = "1";
  foreach (i; 0..999) {
    maxIntString ~= "0";
  }
  BigInt maxInt = BigInt(maxIntString);
  BigInt a = 1;
  BigInt b = 1;
  BigInt temp;
  int i = 2;
  while (b < maxInt) {
    temp = a + b;
    a = b;
    b = temp;
    i++;
  }
  writeln(i);
}