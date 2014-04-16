import std.stdio;

void main() {
  int total = 0;
  foreach (a; 3..1001) {
    if (a%2 == 0) total += (a - 2) * a;
    else total += (a - 1) * a;
  }
  writeln(total);
}