import std.stdio;

import sieve;

void main() {
  bool[] sieve = Sieve(1_000_000);
  for (int i = 35; i < 1_000_000; i+= 2) {
    if (!sieve[i - 2]) continue;
    bool prime = false;
    for (int s = 1; 2 * s * s < i && !prime; s++) {
      if (!sieve[i - 2 * s * s - 2]) prime = true;
    }
    if (prime) continue;
    writeln(i);
    return;
  }
}