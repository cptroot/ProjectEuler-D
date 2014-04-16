import std.stdio;

byte EndPos(int n) {
  static byte[10_000_000] stored;
  static bool init = false;
  if (!init) {
    stored[1] = 1;
    stored[89] = 2;
    init = true;
  }
  immutable int orig = n;
  if (stored[n] != 0) return stored[n];
  int sum = 0;
  while (n != 0) {
    int rem = n % 10;
    n -= rem;
    n /= 10;
    sum += rem * rem;
  }
  stored[orig] = EndPos(sum);
  return stored[orig];
}

void main() {
  long total = 0;
  foreach (i; 1..10_000_000) {
    if (EndPos(i) == 2) total++;
    if (total < 0) throw new Exception("negative numbers");
  }
  writeln(total);
}