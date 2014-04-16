import std.stdio;
import std.conv;
import std.array;
import std.algorithm;

void main() {
  string input = readln();
  int length = parse!int(input);
  int[][] numbers = new int[][length];
  foreach (i; 0..length) {
    string[] line = split(readln());
    numbers[i] = new int[line.length];
    foreach (j, s; line) {
      numbers[i][j] = to!int(s);
    }
  }
  for (int i = length - 1; i > 0; i--) {
    foreach (j; 0..(numbers[i].length - 1)) {
      numbers[i - 1][j] += numbers[i][j] > numbers[i][j + 1] ? numbers[i][j] : numbers[i][j + 1];
    }
  }
  writeln(numbers[0][0]);
}