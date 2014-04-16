import std.stdio;
import std.math;
import std.conv;
import std.algorithm;

byte[] toArray(int num) {
  int length = to!int(floor(log10(num))) + 1;
  byte[] result;
  foreach (i; 0..length) {
    result ~= num % 10;
    num -= result[i];
    num /= 10;
  }
  return result;
}

bool isPalindromic(byte[] num) {
  foreach (i; 0..num.length / 2) {
    if (num[i] != num[$ - i - 1]) return false;
  }
  return true;
}

void main() {
  int total = 0;
  foreach (num; 1..10_000) {
    int index = 0;
    auto numArray = toArray(num);
    byte[] rev;
    do {
      rev = numArray.dup;
      reverse(rev);
      numArray[] += rev[];
      foreach (i, ref value; numArray) {
        while (value >= 10) {
          value -= 10;
          if (i + 1 < numArray.length) numArray[i + 1]++;
          else numArray ~= 1;
        }
      }
      index++;
    } while (index <= 50 && !isPalindromic(numArray));
    if (num == 4994) writeln(index);
    if (index == 51) total++;
  }
  writeln(total);
}