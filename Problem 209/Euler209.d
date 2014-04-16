import std.stdio;
import std.bigint;

void main() {
  bool[6][bool[6]] mapping;
  bool[6] zero = [false, false, false, false, false, false];
  bool[6] current = zero.dup;
  int total;
  int[] lengths = [1];

  mapping[zero] = zero;

  while(total > 0 || !increase(current)) {
    if (total == 0) {
      if (current in mapping) continue;
      writeln();
      total++;
      mapping[current] = map(current);
      writeln(current, " -> ", mapping[current]);
      current = mapping[current].dup;
    } else {
      if (current in mapping) {
        lengths ~= total;
        total = 0;
        current = zero.dup;
      } else {
        mapping[current] = map(current);
        writeln(current, " -> ", mapping[current]);
        current = mapping[current].dup;
        total++;
      }
    }
  }

  long product = 1;

  foreach (length; lengths) {
    product *= options(length);
    writeln(options(length));
  }
  writeln(lengths);
  writeln(product);
}

long options(int n) {
  long total = 0;
  foreach (k; 0..n/2 + 1) {
    total += binomial(n - 1 - k, k - 1);
    total += binomial(n - k, k);
    if (total < 0) throw new Exception("WTF?");
  }
  return total;
}

long binomial(long n, long k) {
  if (k == 0) return 1;
  if (k < 0) return 0;
  if (n <= 0) return 0;
  BigInt result = 1;
  foreach (i; 0..k) {
    result *= BigInt(n - i);
  }
  foreach (i; 2..k+1) {
    BigInt temp = result / BigInt(i);
    //writeln(result, " ", temp, " ", i);
    result = temp;
  }
  //writeln(n, " ", k, ": ", result);
  return result.toLong;
}

bool[6] map(bool[6] array) {
  bool[6] temp = array.dup;
  bool[6] result;
  result[0..5] = temp[1..6];
  result[5] = array[0] ^ (array[1] & array[2]);
  return result;
}

bool increase(ref bool[6] array) {
  if (array[0]) {
    if (array[1]) {
      if (array[2]) {
        if (array[3]) {
          if (array[4]) {
            if (array[5]) {
              return true;
            }
            array[5] = !array[5];
          }
          array[4] = !array[4];
        }
        array[3] = !array[3];
      }
      array[2] = !array[2];
    }
    array[1] = !array[1];
  }
  array[0] = !array[0];
  return false;
}