import std.stdio;
import std.conv;
import sieve;

bool isPrime(long num, int[] sieve) {
  if (num > 1_000_000L * 1_000_000L) throw new Exception("num is to high, " ~ to!string(num));
  foreach (i, value; sieve) {
    if (num != value && num % value == 0) return false;
  }
  return true;
}

void main() {
  bool[] sieve = Sieve(1_000_000);
  int[] shortenedSieve = ShortenSieve(sieve);
  writeln("Finished with sieve");
  double ratio = 1;
  double primes = 0;
  double total = 1;
  long i = 1;
  long n = 0;
  while (ratio > .1) {
    n += 2;
    foreach (j; 0..4) {
      i += n;
      if (isPrime(i, shortenedSieve)) primes++;
      total++;
    }
    ratio = primes / total;
    writeln(ratio, " ", n + 1);
  }
  writeln(n + 1);
}

unittest {
  int[] shortSieve = ShortenSieve(Sieve(1_000));
  assert(isPrime(3, shortSieve));
}