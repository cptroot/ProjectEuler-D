import std.stdio;

void main() {
  int total = 0;
  int[] ones = [0, 3, 3, 5, 4, 4, 3, 5, 5, 4];
  int[] teens = [3, 6, 6, 8, 8, 7, 7, 9, 8, 8];
  int[] tens = [6, 6, 5, 5, 5, 7, 6, 6];
  foreach (i; 1..1001) {
    if (i == 1000) {
      total += 11;
      continue;
    }
    int firstOne = i % 10;
    int firstTwo = i % 100;
    int hundreds = i - firstTwo;
    if (hundreds != 0) {
      if (firstTwo != 0)
        total += 3;
      total += ones[hundreds / 100];
      total += 7;
    }
    switch (firstTwo) {
      case 20: .. case 99:
        total += tens[(firstTwo - firstOne) / 10 - 2];
      case 0: .. case 9:
        total += ones[firstOne];
        break;
      default:
        //writeln(firstTwo);
        total += teens[firstTwo - 10];
        break;
    }
  }
  writeln(total);
}