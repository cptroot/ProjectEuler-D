import std.stdio;
import std.array;
import std.file;

void main() {
  string[] lines = split(readText("roman.txt"), "\r\n");
  int total = 0;
  foreach (line; lines) {
    int initialLength = line.length;
    line = replace(line, "IIIII", "V");
    line = replace(line, "VV", "X");
    line = replace(line, "XXXXX", "L");
    line = replace(line, "LL", "C");
    line = replace(line, "CCCCC", "D");
    line = replace(line, "DD", "M");
    line = replace(line, "VIIII", "IX");
    line = replace(line, "IIII", "IV");
    line = replace(line, "LXXXX", "XC");
    line = replace(line, "XXXX", "XL");
    line = replace(line, "DCCCC", "CM");
    line = replace(line, "CCCC", "CD");
    total += initialLength - line.length;
  }
  writeln(total);
}