import std.stdio;
import std.conv;


void main() {
  long maxLength = 0;
  int maxNum = 1;
  int temp;
  for (int i = 1; i <= 1_000_000; i++) {
    temp = memoizedCollatz(i);
    if (maxLength < temp) {
      maxLength = temp;
      maxNum = i;
    }
  }
  writeln(maxNum);
}

int memoizedCollatz(long n) {
  static int[1_000_000] memo;
  static bool init = false;
  if (!init) {
    memo[1] = 1;
    init = true;
  }
  
  if (n >= 1_000_000) {
    long next = 0;
    if (n % 2 == 0) next = n / 2;
    else next = 3 * n + 1;
    return memoizedCollatz(next) + 1;
  }
  
  if (memo[n] != long.init) return memo[n];
  
  long next = 0;
  if (n % 2 == 0) next = n / 2;
  else next = 3 * n + 1;
  
  memo[n] = memoizedCollatz(next) + 1;
  return memo[n];
}