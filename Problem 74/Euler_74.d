import std.stdio;
import std.typecons;
import std.algorithm;

int factorial(int n) {
  switch (n) {
    case 0: case 1:
      return 1;
      break;
    case 2:
      return 2;
      break;
    case 3:
      return 6;
      break;
    case 4:
      return 24;
      break;
    case 5:
      return 120;
      break;
    case 6:
      return 720;
      break;
    case 7:
      return 5040;
      break;
    case 8:
      return 40320;
      break;
    case 9:
      return 362880;
      break;
    default:
      return -1;
      break;
  }
}

int getLength(int n, int[] numbers, int[int] bigRepeats, int[] previous) {
  if (n < numbers.length && numbers[n] != -1) return numbers[n];
  if (n >= numbers.length && n in bigRepeats) return bigRepeats[n];
  previous ~= n;
  int copy = n;
  int value = 0;
  while (copy != 0) {
    value += factorial(copy % 10);
    copy -= copy % 10;
    copy /= 10;
  }
  int result = countUntil(previous, value);
  //writeln(n, " ", value, " ", previous, " ", result);
  if (result != -1) {
    foreach (i; result..previous.length) {
      if (i < numbers.length) {
        numbers[previous[i]] = previous.length - result;
      } else {
        bigRepeats[previous[i]] = previous.length - result;
      }
    }
    return result - previous.length + 1;
  }
  result = getLength(value, numbers, bigRepeats, previous) + 1;
  if (result == 0) {
    if (value < numbers.length) result = numbers[value];
    else result = bigRepeats[value];
  }
  if (n < numbers.length) {
    if (result <= 0) {
      //numbers[n] = 0;
    } else {
      numbers[n] = result;
    }
  }
  else {
    if (result <= 0) {
      //bigRepeats[n] = 0;
    } else {
      bigRepeats[n] = result;
    }
  }
  return result;
}

void main() {
  int[] numbers = new int[1000000];
  int[int] bigRepeats;
  numbers[] = -1;
  int total = 0;
  foreach (n; 1..1000000) {
    if (getLength(n, numbers, bigRepeats, []) == 60) {
      total++;
    }
  }
  writeln(numbers[69]);
  writeln(total);
}
  