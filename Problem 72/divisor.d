import std.stdio;
import std.math;
import std.algorithm;

int SumOfDivisors(int[] sieve, int input, bool proper = true) {
  int[] divisors = Divisors(sieve, input);
  
  int[] divisors2 = [];
  int[] iter = new int[divisors.length];
  iter[0] = -1;
  int num = reduce!( (a, b) { return a * (b + 1); })(1, divisors);
  for (int i = 0; i < num - proper; i++) {
    iter[0]++;
    int j = 0;
    while (iter[j] > divisors[j]) {
      iter[j] = 0;
      j++;
      if (j == divisors.length) break;
      iter[j]++;
    }
    int divisor = 1;
    foreach (k; 0..divisors.length) {
      divisor *= pow(sieve[k], iter[k]);
    }
    divisors2 ~= divisor;
  }
  auto total = reduce!( (a, b) { return a + b; })(0, divisors2);
  
  return total;
} // Line 30

int[] Divisors(int[] sieve, int input) {
  static int[] stored;
  int[] divisors = new int[sieve.length];
  int divisor = 0;
  int orig = input;

  if (stored.length < 1000000) {
    stored.length = 1000000;
  }
  if (input >= stored.length) {
    stored.length=input + 100;
  }

  while (input != 1) {
    if (stored[input] != 0){
      divisor = stored[input];
      divisors[divisor]++;
      input /= sieve[divisor];
      continue;
    }
    if (input % sieve[divisor] == 0) {
      divisors[divisor]++;
      stored[input] = divisor;
      input /= sieve[divisor];
      continue;
    }
    divisor++;
  }
  return divisors;
}