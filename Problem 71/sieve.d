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