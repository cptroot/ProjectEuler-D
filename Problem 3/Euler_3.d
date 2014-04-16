import std.stdio;
import std.math;
import std.conv;

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
  string line = readln();
  long input = parse!(long)(line);
  writeln(input);
  auto sqrtInput = sqrt(input);
  long lastPrime = input;
  while (input != 1) {
    if (input - 2 < 1_000_000)
      if (!sieve[cast(int)input - 2]) {
        writeln(input);
        return ;
      }
    for (int i = 2; i <= sqrtInput; i++) {
      if (!sieve[i - 2]) {
        if (input % i == 0) {
          input /= i;
          lastPrime = i;
        }
      }
    }
  }
  writeln(lastPrime);
}