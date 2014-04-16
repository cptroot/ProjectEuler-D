import std.stdio;

long factorial(long n) {
  if (n == 1) return 1;
  return n * factorial(n - 1);
}

const int length = 15;

void main() {
  byte[length] iter;
  iter[] = 0;
  for (int j = 0; j < length / 2 + 1; j++) {
    iter[j] = 1;
  }

  int hammond_weight = length / 2 + 1;

  int i;

  long total_numerator = 0;
  long temp = 0;

  while (1) {
    if (hammond_weight > length / 2) {
      temp = 1;
      for (int j = 0; j < length; j++) {
        if (!iter[j])
          temp *= j + 1;
      }
      total_numerator += temp;
    }

    iter[0]++;
    hammond_weight++;
    for (i = 0; i < length; i++) {
      if (iter[i] == 2) {
        if (i == length - 1) break;
        iter[i + 1]++;
        iter[i] = 0;
        hammond_weight--;
      }
    }
    if (i == length - 1) break;
  }

  writeln(factorial(length + 1) / total_numerator);
  writeln(total_numerator);
}