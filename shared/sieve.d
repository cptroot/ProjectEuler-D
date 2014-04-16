import std.stdio;
import std.conv;
import std.math;
import std.algorithm;
import std.typecons;

//Sieve of Eratosthenes, includes limit
bool[] Sieve(int limit) {
  float sqrtLimit = sqrt(to!float(limit));
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

//Sieve of Eratosthenes, includes limit
Tuple!(bool[], int[]) SieveHash(int limit) {
  float sqrtLimit = sqrt(to!float(limit));
  // true denotes composite number
  bool[] sieve = new bool[limit - 1];
  int[] hash = new int[limit + 1];
  int[] edit = [];
  int last = 0;
  for (auto index = 2; index < sqrtLimit; index++) {
    if (!sieve[index - 2]) {
      hash[index] = index;
      for (auto i = index; i <= limit / index; i++) {
        if (!sieve[i - 2]) {
          edit ~= [i * index - 2];
          hash[i * index] = index;
        }
      }
      foreach (comp; edit)
        sieve[comp] = true;
    }
    last = index;
  }
  foreach (i; last + 1..limit) {
    if (!sieve[i - 2]) {
      hash[i] = i;
    }
  }
  return tuple(sieve, hash);
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
  foreach(int i, value; sieve) {
    if (!value) {
      shortened[index] = i + 2;
      index++;
    }
  }
  return shortened;
}

//Sieve out of prime divisor counts
int[] DivisorSieve(size_t limit) {
  float sqrtLimit = sqrt(cast(real)limit);
  // true denotes composite number
  int[] sieve = new int[limit - 1];
  int[] edit = [];
  for (auto index = 2; index < sqrtLimit; index++) {
    if (sieve[index - 2] == 0) {
      edit = [];
      for (auto i = 2; i <= limit / index; i++) {
        edit ~= [i * index - 2];
      }
      foreach (comp; edit)
        sieve[comp]++;
    }
  }
  return sieve;
}

//Totient function results from sieve.

size_t[] Totient(bool[] sieve, size_t limit) {
  size_t[] result;
  result.length = limit - 1;
  result[] = 1;

  size_t p;
  foreach (i, composite; sieve) {
    if (composite) continue;
    p = i + 2;

    for (int power = 1; power <= log10(limit) / log10(p); power++) {
      size_t p_raised = pow(p, power);
      for (size_t k = 1; k * p_raised < limit; k++) {
        if (k % p == 0) continue;

        result[k * p_raised - 2] *= p_raised / p * (p - 1);
      }
    }
  }
  return result;
}