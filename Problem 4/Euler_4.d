import std.stdio;

void main() {
  int max = 0;
  foreach (a; 100..1000) {
    foreach (b; 100..1000) {
      auto product = a * b;
      if (isPalindrome(product)) {
        if (product > max) {
          max = product;
        }
      }
    }
  }
  writeln(max);
}

bool isPalindrome(int number) {
  int[] numberArray = [];
  while (number != 0) {
    numberArray ~= [number % 10];
    number -= number % 10;
    number /= 10;
  }
  for (int i = 0; i < numberArray.length / 2; i++) {
    if (numberArray[i] != numberArray[$ - i - 1]) {
      return false;
    }
  }
  return true;
}