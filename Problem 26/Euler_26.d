import std.stdio;
import std.algorithm;

int LengthRepeater(int divisor) {
  int[] dividends = [1];
  int[] quotient;
  int index = 0;
  while (dividends.countUntil(dividends[index]) == dividends.length - 1) {
    quotient ~= dividends[index] / divisor;
    int difference = dividends[index] - divisor * quotient[index];
    dividends ~= difference * 10;
    index++;
  }
  int first = dividends.countUntil(dividends[index]);
  return index - first;
}

void main() {
  int max = 2;
  int maxLength = 0;
  foreach (d; 2..1000) {
    int value = LengthRepeater(d);
    if (value > maxLength) {
      maxLength = value;
      max = d;
    }
  }
  writeln(max);
}