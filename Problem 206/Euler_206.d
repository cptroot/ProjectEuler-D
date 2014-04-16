import std.stdio;
import std.bigint;
import std.conv;
import std.math;

bool isValid(string str) {
  if (str[0] != 1 + 48) return false;
  if (str[2] != 2 + 48) return false;
  if (str[4] != 3 + 48) return false;
  if (str[6] != 4 + 48) return false;
  if (str[8] != 5 + 48) return false;
  if (str[10] != 6 + 48) return false;
  if (str[12] != 7 + 48) return false;
  if (str[14] != 8 + 48) return false;
  if (str[16] != 9 + 48) return false;
  if (str[18] != 0 + 48) return false;
  return true;
}

void main() {
  writeln(typeof( 1_000_000_000_000_000_000D));
  BigInt x = BigInt(1010101010);
  BigInt x2 = x * BigInt(2);
  BigInt max = BigInt(1389026630);
  BigInt sqr = x * x;
  string str;
  sqr.toString(delegate void (const (char)[] s) {str = to!string(s);}, "d");
  while (!isValid(str)) {
    x2 += 2;
    sqr += x2 - BigInt(1);
    sqr.toString(delegate void (const (char)[] s) {str = to!string(s);}, "d");
    if (str[10..$] == "000000000") writeln(str);
    if (str[2] != 2 + 48) {
      //int x = str[1] - 48;
      //double base = 1_000_000_000_000_000_000D;
      //base += x * 100_000_000_000_000_000D;
      //x2 = BigInt(2 * sqrt(base));
    }
  }
  writeln(x2 / BigInt(2));
}