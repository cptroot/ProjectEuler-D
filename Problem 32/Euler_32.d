import std.stdio;
import std.conv;
import std.algorithm;

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
  int product;
  int[] products;
  int sum;
  string number;
  void multiply(int a, int b) {
    product = a * b;
    number = to!string(a) ~ to!string(b) ~ to!string(product);
    if (isPandigital(number)) {
      if (!products.canFind(product)) {
        writeln(a, " ", b, " ", product);
        products ~= product;
        sum += product;
      }
    }
  }
  foreach (a; 1..10) {
    foreach (b; 1000..10000) {
      multiply(a, b);
    }
  }
  foreach (a; 10..100) {
    foreach (b; 100..1000) {
      multiply(a, b);
    }
  }
  writeln(sum);
}
  