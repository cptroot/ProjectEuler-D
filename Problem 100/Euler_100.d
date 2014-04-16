import std.stdio;
import std.bigint;
import std.typecons;
import std.conv;

void main() {
  BigInt n = BigInt("585786438000");
  BigInt d = BigInt("1000000000000");
  //BigInt n = BigInt("1");
  //BigInt d = BigInt("50");
  BigInt One = BigInt(1);
  BigInt Two = BigInt(2);
  Tuple!(BigInt, BigInt) nsqr;
  nsqr[0] = n * n - n;
  nsqr[1] = nsqr[0] + Two * (n);
  Tuple!(BigInt, BigInt, BigInt) dsqr;
  dsqr[1] = d * d - d;
  dsqr[0] = dsqr[1] + Two * (d);
  dsqr[2] = dsqr[1] - Two * (d + One);
  while(Two * nsqr[0] != dsqr[1]) {
    d += One;
    dsqr[1] = dsqr[0];
    dsqr[2] = dsqr[1];
    dsqr[0] += Two * (d);
    while (Two * nsqr[0] < dsqr[1]) {
      n += One;
      nsqr[0] = nsqr[1];
      nsqr[1] += Two * (n);
    }
  }
  string str;
  n.toString( (const(char)[] s) { str = to!string(s);}, "d");
  writeln(str);
}