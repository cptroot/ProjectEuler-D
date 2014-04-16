import std.stdio;
import std.math;
import std.conv;
import std.algorithm;

long tenth(long n) {
  return 1 - n + n * n - n * n * n
    + pow(n, 4) - pow(n, 5) + pow(n, 6) - pow(n, 7)
    + pow(n, 8) - pow(n, 9) + pow(n, 10);
}

void main() {
  foreach (i; 1..11) writeln(tenth(i));
  long[] fits = [1];
  foreach (k; 1..11) {
    long[] numerators;
    long[] denominators;
    foreach (n; 1..k + 1) {
      long total = 1;
      foreach (i; 1..k + 1) {
        if (i == n) continue;
        total *= n - i;
      }
      numerators ~= tenth(n);
      denominators ~= total;
    }
    bool good = true;
    int x = k + 1;
      double value = 0;
      foreach (n; 1..k + 1) {
        long total = 1;
        foreach (i; 1..k + 1) {
          if (i == n) continue;
          total *= x - i;
        }
        total *= numerators[n - 1];
        value += to!double(total) / to!double(denominators[n - 1]);
        write(to!string(value) ~ " ");
      }
      writeln();
      writeln(numerators, denominators);
      writeln(k, " ", x, " ", value, " ", to!long(value));
      writeln();
      if (!canFind(fits, to!long(value))) fits ~= to!long(value);
    
  }
  writeln(fits);
  long total = 0;
  foreach (v; fits) total += v;
  writeln(total);
}