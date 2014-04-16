import std.stdio;
import std.random;
import std.conv;

void main() {
  long games = 0;
  long wins = 0;
  
  double old = -1;
  double current = -2;

  while (old != current) {
    old = current;
    foreach (i;0..1_000_000) {
      games++;
      int total;
      foreach (_;0..9) {
        total += uniform(1, 5);
      }
      foreach (_;0..6) {
        total -= uniform(1, 7);
      }
      if (total > 0) wins++;
    }
    current = (to!double(wins) / to!double(games));
    writefln("%.7f", current);
  }
  writeln(current);
}