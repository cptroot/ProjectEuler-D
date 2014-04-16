import std.stdio;
import std.math;

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

void main() {
  auto sieve = Sieve(1_000_000);
  writeln("finished sieve");
  auto total = 0;
  int i = 0;
  for (i = 0; total != 10_001; i++)
    if (!sieve[i])
      total++;
  writeln(i + 1);
}