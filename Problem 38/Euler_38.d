import std.stdio;
import std.algorithm;
import std.conv;

bool isPandigital(string number) {
  if (number.length != 9) return false;
  static bool[9] hasDigit = false;
  hasDigit[] = false;
  foreach (c; number) {
    if (c != '0') hasDigit[c - 49] = true;
  }
  return reduce!( (a, b) { return a & b;})(true, hasDigit);
}

void main() {
  int max = 0;
  void checkPandigital(int i) {
    int n = 1;
    string product = to!string(i);
    while (product.length < 9) {
      n++;
      product ~= to!string(i * n);
    }
    if (product.length > 9) return;
    int value = to!int(product);
    if (value > max) {
      if (isPandigital(product)) {
        max = value;
      }
    }
  }
  foreach (i; 9..10) {
    checkPandigital(i);
  }
  foreach (i; 90..100) {
    checkPandigital(i);
  }
  foreach (i; 900..1000) {
    checkPandigital(i);
  }
  foreach (i; 9000..10000) {
    checkPandigital(i);
  }
  writeln(max);
}