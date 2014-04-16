import std.stdio;
import std.math;
import std.conv;
import std.typecons;

int maxInDir(int[][] array, Tuple!(int, int) start, Tuple!(int, int) dir) {
  int maxSoFar = 0;
  int maxEndingHere = 0;

  Tuple!(int, int) current = start;
  while((current[0] < array.length && current[0] >= 0) &&
        (current[1] < array[0].length && current[1] >= 0)) {
    maxEndingHere = to!int(fmax(array[current[0]][current[1]], maxEndingHere + array[current[0]][current[1]]));
    maxSoFar = to!int(fmax(maxSoFar, maxEndingHere));
    current[0] += dir[0];
    current[1] += dir[1];
  }
  return maxSoFar;
}

void main() {
  /*int[][] array = [[-2, 5, 3, 2],
                   [9, -6, 5, 1],
                   [3, 2, 7, 3],
                   [-1, 8, -4, 8]];*/

  int[][] array;
  array.length = 2000;

  int x = 0;
  int y = 0;

  int[] current;
  current.length = 2000;

  foreach (i; 1L..56L) {
    long result = 100003 - 200003 * i + 300007 * i * i * i;
    result %= 1000000;
    result -= 500000;
    current[i - 1] = to!int(result);
  }

  array[0].length = 2000;
  array[0] = current;

  x = 55;

  while (y < 2000) {
    if (x == 0) array[y].length = 2000;
    long total = 1000000;
    if (x >= 24) total += array[y][x - 24];
    else total += array[y - 1][x - 24 + 2000];

    if (x >= 55) total += array[y][x - 55];
    else total += array[y - 1][x - 55 + 2000];

    total %= 1000000;
    total -= 500000;

    array[y][x] = to!int(total);
    x++;
    if (x == 2000) { y++; x = 0; }
  }

  int maxSum = int.min;
  
  foreach (i; 0..array.length) {
    maxSum = to!int(fmax(maxSum, maxInDir(array, tuple(to!int(i), 0), tuple(0, 1))));
    maxSum = to!int(fmax(maxSum, maxInDir(array, tuple(0, to!int(i)), tuple(1, 0))));

    maxSum = to!int(fmax(maxSum, maxInDir(array, tuple(0, to!int(i)), tuple(1, 1))));
    maxSum = to!int(fmax(maxSum, maxInDir(array, tuple(to!int(i), 0), tuple(1, 1))));

    maxSum = to!int(fmax(maxSum, maxInDir(array, tuple(0, to!int(i)), tuple(1, -1))));
    maxSum = to!int(fmax(maxSum, maxInDir(array, tuple(to!int(i), to!int(array[0].length) - 1), tuple(1, -1))));
  }

  writeln(maxSum);
}