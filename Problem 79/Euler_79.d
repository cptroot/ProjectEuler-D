import std.stdio;
import std.file;
import std.array;
import std.typecons;
import std.algorithm;

void main() {
  string text = readText("keylog.txt");
  string[] strings = text.split("\r\n");
  Tuple!(int, int)[] pairs;
  writeln(strings);
  foreach (s; strings) {
    if (s == "") continue;
    int a = s[0] - 48;
    int b = s[1] - 48;
    int c = s[2] - 48;
    if (!canFind(pairs, tuple(a, b))) pairs ~= tuple(a, b);
    if (!canFind(pairs, tuple(a, c))) pairs ~= tuple(a, c);
    if (!canFind(pairs, tuple(b, c))) pairs ~= tuple(b, c);
  }
  foreach (pair; pairs) {
    writeln(pair[0], " ", pair[1]);
  }
}