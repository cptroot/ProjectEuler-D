import std.stdio;
import std.conv;

import sieve;

void main() {
  int total = 0;
  bool[] sieve = Sieve(1_000_000);
  foreach(i; 10..1_000_000) {
    if (sieve[i - 2]) continue;
    string left = to!string(i);
    string right = left;
    bool isPrime = true;
    int temp = 0;
    while (left.length != 1) {
      left = left[0..$ - 1];
      right = right[1..$];
      temp = to!int(left);
      if (temp < 2 || sieve[temp - 2]) {
        isPrime = false;
        break;
      }
      temp = to!int(right);
      if (temp < 2 || sieve[temp - 2]) {
        isPrime = false;
        break;
      }
    }
    if (isPrime) {
      writeln(i);
      total += i;
    }
  }
  writeln(total);
}