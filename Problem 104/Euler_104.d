import std.stdio;
import std.bigint;
import std.conv;

bool isPandigitalF(BigInt n) {
  string num;
  n.toString((const(char)[] str) { num = to!string(str);}, "d");
  if (num.length <= 9) return false;
  string seq = num[0..9];
  bool[9] found = new bool[9];
  foreach (c; seq) {
    if (c == '0') return false;
    if (found[c - 49]) return false;
    found[c - 49] = true;
  }
  seq = num[$ - 9..$];
  found = new bool[9];
  foreach (c; seq) {
    if (c == '0') return false;
    if (found[c - 49]) return false;
    found[c - 49] = true;
  }
  return true;
}

bool isPandigital(string str) {
  if (str.length < 9) return false;
  bool[9] found = new bool[9];
  foreach (c; str) {
    if (c == '0') return false;
    if (found[c - 49]) return false;
    found[c - 49] = true;
  }
  return true;
}

void main() {
  BigInt a1 = BigInt(1);
  BigInt b1 = BigInt(1);
  BigInt c1;
  BigInt a2 = BigInt(1);
  BigInt b2 = BigInt(1);
  BigInt c2;
  string b1str = "1";
  string b2str = "1";
  int index = 2;
  while (!isPandigital(b1str) || !isPandigital(b2str)) {
    if (isPandigital(b1str)) {//writeln(index);
      //readln();
    }
    index++;
    if (index % 100 == 0) writeln(index);
    c1 = a1 + b1;
    a1 = b1;
    b1 = c1;
    c2 = a2 + b2;
    a2 = b2;
    b2 = c2;
    b1.toString((const(char)[] str) { b1str = to!string(str);}, "d");
    if (b1str.length > 20) {
      b1 /= BigInt(10);
      a1 /= BigInt(10);
    }
    if (b1str.length >= 9) {
      b1str = b1str[0..9];
    }
    b2.toString((const(char)[] str) { b2str = to!string(str);}, "d");
    if (b2str.length >= 9) {
      b2str = b2str[$ - 9..$];
    }
    b2 = BigInt(b2str);
    //writeln(b1str);
  }
  writeln(index);
}

