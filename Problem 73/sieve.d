import std.stdio;
import std.math;
import std.algorithm;
import std.typecons;

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

//Sieve of Eratosthenes, includes limit
Tuple!(bool[], int[]) SieveHash(int limit) {
  float sqrtLimit = sqrt(limit);
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
  foreach(i, value; sieve) {
    if (!value) {
      shortened[index] = i + 2;
      index++;
    }
  }
  return shortened;
}