import std.stdio;
import std.math;
import std.algorithm;

//Sieve of Eratosthenes, includes limit
bool[] Sieve(int limit) {
  float sqrtLimit = sqrt(limit);
  // true denotes composite number
  bool[] sieve = new bool[limit - 1];
  int[] edit = [];
  for (auto index = 2; index < sqrtLimit; index++) {
    if (!sieve[index - 2]) {
      for (auto i = index; i <= limit / index; i++) {
        if (!sieve[i - 2])
          edit ~= [i * index - 2];
      }
      foreach (comp; edit)
        sieve[comp] = true;
    }
  }
  return sieve;
}

int[] ShortenSieve(bool[] sieve) {
  int[] shortened;
  int count = 0;
  foreach(i, value; sieve) {
    if (!value) {
      count++;
    }
  }
  shortened = new int[count];
  int index = 0;
  foreach(i, value; sieve) {
    if (!value) {
      shortened[index] = i + 2;
      index++;
    }
  }
  return shortened;
}

int SumOfDivisors(int[] sieve, int input) {
  int[] divisors = Divisors(sieve, input);
  
  int[] divisors2 = [1];
  int[] iter = new int[divisors.length];
  int num = reduce!( (a, b) { return a * (b + 1); })(1, divisors);
  for (int i = 0; i < num - 2; i++) {
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
}

int[] Divisors(int[] sieve, int input) {
  int[] divisors = new int[sieve.length];
  int divisor = 0;

  while (input != 1) {
    if (input % sieve[divisor] == 0) {
      divisors[divisor]++;
      input /= sieve[divisor];
      continue;
    }
    divisor++;
  }
  return divisors;
}

void main() {
  auto sieve = ShortenSieve(Sieve(10_000));
  int[] divisors = new int[10_000];
  int total = 0;
  foreach (i, ref value; divisors) {
    value = SumOfDivisors(sieve, i + 1);
    if (value - 1 < 10_000) {
      if (divisors[value - 1] == i + 1 && value != i + 1) {
        total += value;
        total += i + 1;
        writeln(value, " ", i+1);
      }
    }
  }
  writeln(total);
}