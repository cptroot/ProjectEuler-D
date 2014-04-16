import std.stdio;
import std.math;

void main() {
  int i = 2;
  int total = 1;
  int perfect = 1;

  real temp;
  
  while(perfect * 12345 >= total * 1) {
    i++;
    total++;
    temp = log2(i);
    if (round(temp) == temp) { writeln(i); perfect++; }
  }

  int n = i * 2 - 1;
  //writeln(n);
  long k = n * n - 1;
  k /= 4;
  k = i * (i - 1);
  
  writeln(i, " ", k);
}