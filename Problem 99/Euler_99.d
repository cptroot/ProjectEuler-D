import std.stdio;
import std.math;
import std.file;
import std.array;
import std.conv;
import std.typecons;

void main() {
  int maxLine = -1;
  auto maxPair = tuple(1, 1);
  string[] lines = split(readText("base_exp.txt"), "\r\n");
  foreach (i, line; lines) {
    if (line == "") continue;
    string[] nums = split(line, ",");
    auto pair = tuple(parse!int(nums[0]), parse!int(nums[1]));
    if (pair[1] > maxPair[1] * log10(maxPair[0]) / log10(pair[0])) {
      maxPair = pair;
      maxLine = i + 1;
    }
  }
  writeln(maxLine);
}