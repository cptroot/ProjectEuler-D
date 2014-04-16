import std.stdio;

void main() {
  int n = 1;
  int total = 1;
  foreach (i; 0..500) {
    foreach (j; 0..4) {
      n += (i + 1) * 2;
      total += n;
    }
  }
  writeln(total);
}