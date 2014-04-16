import std.stdio;
import std.conv;

void main() {
  string line;
  long total = 0;
  foreach (i; 0..100) {
    line = readln();
    line = line[0..11];
    total += to!long(line);
  }
  string finalString = to!string(total);
  writeln(finalString[0..10]);
}