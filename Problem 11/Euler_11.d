import std.stdio;
import std.array;
import std.conv;

void main() {
  int[][] grid = new int[][20];
  foreach(ref a; grid) {
    a = new int[20];
  }
  foreach (int i; 0 .. 20) {
    string line = readln();
    string[] nums = split(line);
    foreach (int j; 0 .. 20) {
      grid[i][j] = parse!(int)(nums[j]);
    }
  }

  int max = 0;
  
  int product = 0;
  // Horizontal
  foreach (int i; 0 .. 17) {
    foreach (int j; 0 .. 20) {
      product = grid[i][j] * grid[i + 1][j] * grid[i + 2][j] * grid[i + 3][j];
      if (product > max) {
        max = product;
      }
    }
  }

  // Vertical
  foreach (int i; 0 .. 20) {
    foreach (int j; 0 .. 17) {
      product = grid[i][j] * grid[i][j + 1] * grid[i][j + 2] * grid[i][j + 3];
      if (product > max) {
        max = product;
      }
    }
  }


  // Down Right
  foreach (int i; 0 .. 17) {
    foreach (int j; 0 .. 17) {
      product = grid[i][j] * grid[i + 1][j + 1] * grid[i + 2][j + 2] * grid[i + 3][j + 3];
      if (product > max) {
        max = product;
      }
    }
  }


  // Down Left
  foreach (int i; 0 .. 17) {
    foreach (int j; 0 .. 17) {
      product = grid[i][j + 3] * grid[i + 1][j + 2] * grid[i + 2][j + 1] * grid[i + 3][j];
      if (product > max) {
        max = product;
      }
    }
  }

  writeln(max);
}