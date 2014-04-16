import std.stdio;
import std.math;
import std.conv;

string TenToTwo(int baseTen) {
  string result = "";
  int power = to!int(floor(log2(baseTen)));
  for (int i = power; i >= 0; i--) {
    int value = pow(2, i);
    if (baseTen >= value) {
      baseTen -= value;
      result ~= "1";
    } else result ~= "0";
  }
  return result;
}

bool isPalindrome(string palindrome) {
  foreach(i; 0..palindrome.length / 2) {
    if (palindrome[i] != palindrome[$ - i - 1]) return false;
  }
  return true;
}

void main() {
  int total = 0;
  foreach (i; 1..1_000_000) {
    if (!isPalindrome(to!string(i))) continue;
    string baseTwo = TenToTwo(i);
    if (!isPalindrome(baseTwo)) continue;
    total += i;
    writeln(baseTwo);
    writeln(i);
  }
  writeln(total);
}