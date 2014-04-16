import std.stdio;
import std.string;
import std.conv;

void main() {
  auto paragraph = "";
  auto input = strip(readln());
  while (input != "") {
    paragraph ~= input;
    input = strip(readln());
  }
  auto max = 1;
  auto products = [1, 1, 1, 1, 1];
  for (int i = 0; i < paragraph.length; i++) {
    for (int j = 0; j < 4; j++)
      products[j] = products[j + 1];
    products[4] = 1;
    foreach (ref x; products) {
      x *= cast(int) (paragraph[i]) - 48;
    }
    max = products[0] > max ? products[0] : max;
  }
  writeln(max);
}