import std.stdio;
import std.file;
import std.array;
import std.conv;
import std.math;

void main() {
  int[80][80] mins;
  int[80][80] matrix;
  string[] lines = split(readText("matrix.txt"), "\r\n");
  foreach (i, line; lines) {
    if (line == "") continue;
    string[] nums = split(line, ",");
    foreach (j, num; nums) {
      matrix[i][j] = parse!int(num);
    }
  }
  mins[0][0] = matrix[0][0];
  foreach (n; 1..159) {
    foreach (x; 0..n + 1) {
      if (x > 79 || n - x > 79) continue;
      if (x > 0 && n - x > 0) {
        mins[x][n - x] = matrix[x][n-x] + (mins[x - 1][n - x] < mins[x][n - x - 1] ? mins[x - 1][n - x] : mins[x][n - x - 1]);
      } else if (x > 0) {
        mins[x][n - x] = matrix[x][n - x] + mins[x - 1][n - x];
      } else {
        mins[x][n - x] = matrix[x][n - x] + mins[x][n - x - 1];
      }
      if (mins[x][n - x] < 0) throw new Exception("negative number");
    }
  }
  writeln(mins[79][79]);
}