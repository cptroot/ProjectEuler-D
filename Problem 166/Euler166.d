import std.stdio;

void main() {
  int[4][4] grid;

  long total = 0;
  foreach (num; 0..10_000) {
    if (num % 10 == 0) writeln(num);
    int sum = 0;
    foreach (i; 0..4) {
      grid[0][i] = num % 10;
      sum += grid[0][i];
      num -= num % 10;
    }
    int[6] array;
    foreach (num2; 0..1_000_000) {
      foreach (i; 0..6) {
        array[i] = num % 10;
        num -= array[i];
      }
      grid[1][0] = array[0];
      grid[1][1] = array[1];
      grid[1][2] = array[2];
      grid[2][0] = array[3];
      grid[2][1] = array[4];
      grid[2][2] = array[5];

      bool bad = false;
      foreach (i; 0..3) {
        int diff = sum - grid[0][i] - grid[1][i] - grid[2][i];
        if (diff < 0 || diff > 9) { bad = true; break; }
        grid[3][i] = diff;
      }
      if (bad) continue;
      foreach (i; 0..3) {
        int diff = sum - grid[i][0] - grid[i][1] - grid[i][2];
        if (diff < 0 || diff > 9) { bad = true; break; }
        grid[i][3] = diff;
      }
      if (bad) continue;
      if (grid[0][3] + grid[1][3] + grid[2][3] + grid[3][3] != sum) continue;
      if (grid[0][0] + grid[1][1] + grid[2][2] + grid[3][3] != sum) continue;
      if (grid[0][3] + grid[1][2] + grid[2][1] + grid[3][0] != sum) continue;
      total++;
    }
  }
}