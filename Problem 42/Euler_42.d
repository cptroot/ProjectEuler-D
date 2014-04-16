import std.stdio;
import std.algorithm;
import std.file;
import std.array;

void main() {
  int[] numbers;
  foreach (i; 0..60) {
    numbers ~= i * (i + 1) / 2;
  }
  writeln(numbers);
  string wordsTxt = readText("words.txt");
  wordsTxt = wordsTxt[1..$ - 1];
  string[] words = split(wordsTxt, "\",\"");
  int value;
  int total;
  foreach (s; words) {
    value = 0;
    foreach (c; s) {
      value += c - 64;
    }
    if (numbers.canFind(value)) {
      total++;
      writeln(s);
    }
  }
  writeln(total);
}