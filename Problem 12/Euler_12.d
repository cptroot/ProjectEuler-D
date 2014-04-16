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

int NumDivisors(int[] sieve, int input) {
  int[] divisors = Divisors(sieve, input);
  
  int total = reduce!( (a, b) { return a * (b + 1); })(1, divisors);
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
void main() {
  bool[] sieveInitial = Sieve(1_000_000);
  int[] sieve = ShortenSieve(sieveInitial);
  writeln(sieve[0]);
  int maxDivisors = 0;
  int i = 0;
  for (i = 1; i < 1_000_000 && maxDivisors < 500; i++) {
    int num = i * (i + 1) / 2;
    int outNum = NumDivisors(sieve, num);
    if (maxDivisors < outNum) {
      maxDivisors = outNum;
    }
  }
  writeln(i * (i - 1) / 2);
}

unittest {
  bool[] sieveInitial = Sieve(1_000_000);
  int[] sieve = ShortenSieve(sieveInitial);
  assert(NumDivisors(sieve, 5) == 2);
  assert(NumDivisors(sieve, 28) == 6);
} 