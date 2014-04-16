import std.stdio;
import std.math;

bool isTriangular(long i) {
  double x = (-1 + sqrt(1 + 8 * i)) / 2;
  return x == floor(x);
}

bool isPentagonal(long i) {
  double x = (1 + sqrt(1 + 24 * i)) / 6;
  return x == floor(x);
}

void main() {
  long i = 143;
  while (1) {
    i++;
    long h = i * (2 * i - 1);
    if (isTriangular(h) && isPentagonal(h)) {
      writeln(h);
      return ;
    }
  }
}