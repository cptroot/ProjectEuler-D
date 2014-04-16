import std.stdio;

const int max = 50;

void main() {
  int number = 0;
  number += max * max;
  

  bool[max + 1][max + 1] visited;

  for (int i = 0; i < max; i++) {
    visited[i][] = false;
  }

  int x_0, y_0;
  int n, m;

  for (x_0 = 0; x_0 <= max; x_0++)
    for (y_0 = 0; y_0 <= max; y_0++) {
      if (y_0 == 0 && x_0 == 0) continue;
      if (visited[y_0][x_0]) continue;
      for (n = 1; n * x_0 <= max && n * y_0 <= max; n++) {
        visited[n * y_0][n * x_0] = true;
        for (m = 1; n * x_0 + m * y_0 <= max && n * y_0 - m * x_0 >= 0; m++) {
          number++;
          //writef("up: %d %d %d %d\n", x_0, y_0, n, m);
        }

        for (m = 1; n * x_0 - m * y_0 >= 0 && n * y_0 + m * x_0 <= max; m++) {
          number++;
          //writef("down: %d %d %d %d\n", x_0, y_0, n, m);
        }
      }
    }
  
  writeln(number);
}