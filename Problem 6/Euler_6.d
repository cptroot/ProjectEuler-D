import std.stdio;

void main() {
  int sumSquares = 0;
  foreach (i; 1..101)
    sumSquares += i * i;
  long squareSum = 0;
  auto sum = 100 * 101 / 2;
  squareSum = sum * sum;
  writeln(squareSum - sumSquares);
}