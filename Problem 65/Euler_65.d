import std.stdio;
import std.bigint;
import std.conv;

void main() {
  BigInt top = BigInt(1);
  BigInt bottom = BigInt(0);
  BigInt mid = BigInt(66);
  BigInt temp = BigInt(0);
  foreach (i; 0..33) {
    temp = top;
    top = bottom;
    bottom = temp;
    top += bottom;

    temp = top;
    top = bottom;
    bottom = temp;
    top += mid * bottom;
    
    temp = top;
    top = bottom;
    bottom = temp;
    top += bottom;

    mid -= BigInt(2);
    writeln(mid);
  }
  temp = top;
  top = bottom;
  bottom = temp;
  top += BigInt(2) * bottom;
  string str;
  top.toString( (const(char)[] s) { str = to!string(s); }, "d" );
  int sum = 0;
  foreach (c; str) {
    sum += c - 48;
  }
  writeln(sum);
}