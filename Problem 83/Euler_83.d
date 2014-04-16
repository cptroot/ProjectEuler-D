import std.stdio;
import std.file;
import std.array;
import std.conv;
import std.algorithm;
import std.typecons;

immutable int size = 80;

Tuple!(int, int)[] Neighbors(Tuple!(int, int) pos) {
  Tuple!(int, int)[] temp;
  Tuple!(int, int)[] result;
  temp ~= tuple(pos[0], pos[1] + 1);
  temp ~= tuple(pos[0] + 1, pos[1]);
  temp ~= tuple(pos[0] - 1, pos[1]);
  temp ~= tuple(pos[0], pos[1] - 1);
  foreach (neighbor; temp) {
    if (neighbor[0] < 0 || neighbor[1] < 0) continue;
    if (neighbor[0] > size - 1 || neighbor[1] > size - 1) continue;
    result ~= neighbor;
  }
  return result;
}

void main() {
  string[] lines = split(readText("matrix.txt"), "\r\n");
  int[size][size] matrix;
  foreach (i, line; lines) {
    if (line == "") continue;
    foreach (j, s; split(line, ",")) {
      if (s == "") continue;
      matrix[i][j] = parse!int(s);
    }
  }
  Tuple!(int, int)[] closed;
  Tuple!(int, int)[] open = [tuple(0, 0)];
  int[size][size] g_scores;
  g_scores[0][0] = matrix[0][0];
  while (open.length > 0) {
    Tuple!(int, int) x;
    int minScore = int.max;
    foreach (pos; open) {
      if (minScore > g_scores[pos[0]][pos[1]] + 2 * (size - 1) - pos[0] - pos[1]) {
        x = pos;
        minScore = g_scores[pos[0]][pos[1]] + 2 * (size - 1) - pos[0] - pos[1];
      }
    }
    if (x == tuple(size - 1, size - 1)) {
      writeln(minScore);
      return;
    }
    int index = countUntil(open, x);
    open = open[0..index] ~ open[index + 1..$];
    closed ~= x;
    foreach (y; Neighbors(x)) {
      if (canFind(closed, y)) continue;

      int g_score = g_scores[x[0]][x[1]] + matrix[y[0]][y[1]];
  
      bool isBetter = false;

      if (!canFind(open, y)) {
        open ~= y;
        isBetter = true;
      } else if (g_score < g_scores[y[0]][y[1]]) {
        isBetter = true;
      }
  
      if (isBetter == true) {
        g_scores[y[0]][y[1]] = g_score;
      }
    }
  }
}