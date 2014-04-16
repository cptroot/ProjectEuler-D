import std.stdio;
import std.math;
import std.conv;
import std.algorithm;

byte[] toArray(long i) {
  byte[] result;
  result.length = to!int(floor(log10(i))) + 1;
  foreach (index; 0..result.length) {
    result[index] = i % 10;
    i /= 10;
  }
  return result;
}

bool palindrome(long i) {
  byte[] array = toArray(i);
  foreach (index; 0..array.length / 2) {
    if (array[index] != array[$ - index - 1]) return false;
  }
  return true;
}

void main() {
  long index = 2;
  long[] sums = [1];
  long total = 0;

  long[] found;

  int number = 0;

  int removed = 0;
  while (index * index < 50000000) {
    if (index % 100 == 0) writeln(index);
    long square = index * index;
    sums[] += square;
    /*foreach (ref sum; sums) {
      sum += square;
    }*/

    foreach (i, sum; sums) {
      if (palindrome(sum) && sum < 100000000) {
        if (canFind(found, sum)) continue;
        writeln(sum, " ", i + 1 + removed, " ", index);
        //readln();
        total += sum;
        number++;
        found ~= sum;
      }
    }

    if (sums[0] >= 100000000) {
      sums = sums[1..$];
      removed++;
    }

    sums ~= square;
    index++;
  }

  writeln(total);
  writeln(number);
}