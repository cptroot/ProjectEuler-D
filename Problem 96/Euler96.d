import std.stdio;
import std.file;
import std.conv;
import std.array;
import std.string;
import std.typecons;
import std.algorithm;

void main() {
  string[] lines = split(removechars(readText("sudoku.txt"), "\r"), "\n");
  writeln(lines.length);

  int index = 0;

  int total = 0;
  
  foreach (_; 0..50) {
    index++;
    cell[9][9] grid;
    Tuple!(uint, uint)[] updates;

    foreach (i; 0u..9u) {
      writeln(lines[i + index]);
      foreach (j; 0u..9u) {
        grid[i][j] = cell(cast(byte)(lines[i + index][j] - 48));
        updates ~= tuple(i, j);
      }
      updates ~= tuple(10u, i + 1);
    }

    writeln();

    solve(grid, updates);

    bool solved = true;
    int minOptions = 10;
    Tuple!(int, int)[] pos;
    byte[][] options;

    foreach (i; 0..9) {
      foreach (j; 0..9) {
        if (grid[i][j].value == 0) {
          solved = false;
          if (grid[i][j].options.length < minOptions) {
            minOptions = grid[i][j].options.length;
            options = [grid[i][j].options];
            pos = [tuple(i + 1, j + 1)];
          } else if (grid[i][j].options.length == minOptions) {
            options ~= grid[i][j].options;
            pos ~= tuple(i + 1, j + 1);
          }
        }
      }
    }

    if (solved) total++;
    else {
      /*foreach (i; 0..9) {
        foreach (j; 0..9) {
          write(grid[i][j].value);
          if (j % 3 == 2) write(" ");
        }
        writeln();
        if (i % 3 == 2) writeln();
      }
      foreach (i; 0..pos.length) {
        writeln(pos[i], " ", options[i]);
      }
      readln();*/

      int common[];

      foreach (i, point; pos) {
        int temp = 0;
        foreach (j, other; pos) {
          if (i == j) continue;
          if (point[0] == other[0] || point[1] == other[1]) temp++;
        }
        common ~= temp;
      }
      int index = countUntil(common, minPos(common)[0]);

      grid[pos[index][0]][pos[index][1]].value = options[index][0];

      cell[9][9] duplicate;
      while(!solved) {
      foreach (i; 0..9) {
        foreach (j; 0..9) {
        }
      }

      if (solve(duplicate, updates))
    }

    index += 9;
  }
  writeln(total);
}

void solve(cell[9][9] grid, Tuple!(uint, uint)[] updates) {
  bool lastDitch = false;

  while(updates.length > 0) {
    if (updates[0][0] == 10) {
      bool[9][9] options;
      foreach (i; 0u..9u) {
        foreach (j; 0u..9u) {
          options[i][j] = true;
        }
      }

      foreach (i; 0u..9u) {
        foreach (j; 0u..9u) {
          if (grid[i][j].value != 0) options[i][j] = false;
          if (grid[i][j].value != updates[0][1]) continue;
          options[i][j] = false;
          foreach (k; 0..9) {
            if (j != k) options[i][k] = false;
            if (i != k) options[k][j] = false;
          }
          int offsetX = (i / 3) * 3;
          int offsetY = (j / 3) * 3;

          foreach (x; 0..3) {
            foreach (y; 0..3) {
              options[x + offsetX][y + offsetY] = false;
            }
          }
        }
      }

      /*foreach (i; 0..9) {
      foreach (j; 0..9) {
      write(1 ? options[i][j] : 0);
      }
      writeln();
      }
      readln();*/

      foreach (a; 0..3) {
        foreach (b; 0..3) {
          int num = 0;
          Tuple!(uint, uint) pos = tuple(10, 10);
          foreach (i; 0u..3u) {
            foreach (j; 0u..3u) {
              if (options[i + 3 * a][j + 3 * b] == false) continue;
              num++;
              if (num == 1) pos = tuple(i + 3 * a, j + 3 * b);
            }
          }
          if (num == 1) {
            grid[pos[0]][pos[1]].value = to!byte(updates[0][1]);
            updates ~= updates[0];
            foreach (i; 0u..9u) {
              if (pos[1] != i) updates ~= tuple(pos[0], i);
              if (pos[0] != i) updates ~= tuple(i, pos[1]);
            }
            uint offsetX = (pos[0] / 3) * 3;
            uint offsetY = (pos[1] / 3) * 3;

            foreach (i; 0u..3u) {
              foreach (j; 0u..3u) {
                updates ~= tuple(i + offsetX, j + offsetY);
              }
            }
            lastDitch = false;
          }
        }
      }

      int num1 = 0;
      int num2 = 0;

      Tuple!(uint, uint) pos1 = tuple(10, 10);
      Tuple!(uint, uint) pos2 = tuple(10, 10);

      foreach (i; 0u..9u) {
        num1 = 0;
        num2 = 0;
        foreach (j; 0u..9u) {
          if (options[i][j] == true) {
            num1++;
            pos1 = tuple(i, j);
          }
          if (options[j][i] == true) {
            num2++;
            pos2 = tuple(j, i);
          }
        }

        if (num1 == 1) {
          grid[pos1[0]][pos1[1]].value = to!byte(updates[0][1]);
          updates ~= updates[0];
          foreach (j; 0u..9u) {
            if (pos1[1] != j) updates ~= tuple(pos1[0], j);
            if (pos1[0] != j) updates ~= tuple(j, pos1[1]);
          }
          uint offsetX = (pos1[0] / 3) * 3;
          uint offsetY = (pos1[1] / 3) * 3;

          foreach (j; 0u..3u) {
            foreach (k; 0u..3u) {
              updates ~= tuple(j + offsetX, k + offsetY);
            }
          }
          lastDitch = false;
        }

        if (num2 == 1) {
          grid[pos2[0]][pos2[1]].value = to!byte(updates[0][1]);
          updates ~= updates[0];
          foreach (j; 0u..9u) {
            if (pos2[1] != j) updates ~= tuple(pos2[0], j);
            if (pos2[0] != j) updates ~= tuple(j, pos2[1]);
          }
          uint offsetX = (pos2[0] / 3) * 3;
          uint offsetY = (pos2[1] / 3) * 3;

          foreach (j; 0u..3u) {
            foreach (k; 0u..3u) {
              updates ~= tuple(j + offsetX, k + offsetY);
            }
          }
          lastDitch = false;
        }
      }
    } else {
      uint x = updates[0][0];
      uint y = updates[0][1];
      if (grid[x][y].value != 0) { updates = updates[1..$]; continue; }
      grid[x][y].options = Options(grid, x, y);
      if (grid[x][y].options.length == 1) {
        grid[x][y].value = grid[x][y].options[0];
        foreach (i; 0u..9u) {
          if (y != i) updates ~= tuple(x, i);
          if (x != i) updates ~= tuple(i, y);
        }
        uint offsetX = (x / 3) * 3;
        uint offsetY = (y / 3) * 3;

        foreach (i; 0u..3u) {
          foreach (j; 0u..3u) {
            updates ~= tuple(i + offsetX, j + offsetY);
          }
        }
        lastDitch = false;
      }
    }
    updates = updates[1..$];
    if (updates.length == 0 && !lastDitch) {
      foreach (i; 1u..10u) {
        updates ~= tuple(10u, i);
      }
      lastDitch = true;
    }
  }
}

struct cell {
  byte value;
  byte[] options;
}

byte[] Options(cell[9][9] grid, uint x, uint y) {
  byte[] result = [1, 2, 3, 4, 5, 6, 7, 8, 9];
  foreach (i; 0..9) {
    remove(result, grid[x][i].value);
    remove(result, grid[i][y].value);
  }
  int offsetX = (x / 3) * 3;
  int offsetY = (y / 3) * 3;

  foreach (i; 0..3) {
    foreach (j; 0..3) {
      remove(result, grid[i + offsetX][j + offsetY].value);
    }
  }

  return result;
}

void remove(ref byte[] array, byte value) {
  if (canFind(array, value)) {
    int index = countUntil(array, value);
    array = array[0..index] ~ array[index + 1..$];
  }
}