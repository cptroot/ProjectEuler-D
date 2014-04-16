import std.stdio;
import std.algorithm;

void main() {
  int total = 0;

  foreach (die1; NChooseK(0..10, 6)) {
    foreach (die2; NChooseK(0..10, 6, die1)) {
      if (check(die1, die2)) total++;
    }
  }
  
  writeln(total);
}

bool check(int[] a, int[] b) {
  static int[] values = [[0, 1], [0, 4], [0, 9], [1, 6], [2, 5], [3, 6], [4, 9], [6, 4], [8, 1]];

  foreach (value; values) {
    bool value06, value16;
    value06 = value[0] == 6 || value[0] == 9;
    value16 = value[1] == 6 || value[1] == 9;
    if (value06 && value16) {
      if ((canFind(a, 6) || canFind(a, 9)) && (canFind(b, 6) || canFind(b, 9)) continue;