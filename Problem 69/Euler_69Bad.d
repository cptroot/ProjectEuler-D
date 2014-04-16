import std.stdio;
import std.conv;
import std.algorithm;
import sieve;
import divisor;

void main() {
  int[] shortSieve = ShortenSieve(Sieve(1000000));
  double max = 1;
  int maxNum = 1;
  foreach (n; 2..1000001) {
    int[] divisors = Divisors(shortSieve, n);
    double limit = cast(double)n / max;
    int numPrime = 0;
    int[] iterator = new int[divisors.length];
    int count = 0;
    int total = reduce!((a, b) {return a * ((b > 0) + 1);}) (1, divisors);
    while (count < total) {
      int bottom = 1;
      int num = 0;
      foreach (i, value; iterator) {
        if (!value) continue; 
        bottom *= shortSieve[i];
        num++;
      }
      if (num % 2 == 1) bottom = -bottom;
      numPrime += n / bottom;
      //writeln(numPrime);
      iterator[0]++;
      count++;
      foreach (i, ref value; iterator) {
        if (value > (divisors[i] > 0)) {
          value = 0;
          if (i + 1 < iterator.length) iterator[i + 1]++;
        }
      }
    }
    //writeln(n, " ", limit, " ", numPrime, ".");
    if (numPrime >= limit) continue;
    max = cast(double)n / cast(double)numPrime;
    maxNum = n;
    writeln(maxNum, " ", max);
  }
  writeln(maxNum);
}