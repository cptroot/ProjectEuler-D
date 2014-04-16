import std.stdio;
import std.file;
import std.array;
import std.conv;

void swap(ref int a, ref int b) {
  int c = b;
  b = a;
  a = c;
}

int intersections(int x1, int y1, int x2, int y2) {
  if (y1 < y2)
    if (y1 > 0 || y2 < 0) return 0;
  else if (y1 < 0 || y2 > 0) return 0;
  if (x2 < 0 && x1 < 0) return 0;
  
  int bottom = y1 - y2;
  int top = x2 * y1 - x1 * y2;

  if (bottom * top <= 0) return 0;

  if (x1 > x2) swap(x1, x2);
  if (top <= x1 * bottom || top >= x2 * bottom) return 0;
  else return 1;
} 

void main() {
  string[] lines = split(readText("triangles.txt"), "\r\n");
  int intersection;
  int total = 0;
  foreach (line; lines) {
    if (line == "") continue;
    intersection = 0;
    string[] coords = split(line, ",");
    int x1 = parse!int(coords[0]);
    int y1 = parse!int(coords[1]);
    int x2 = parse!int(coords[2]);
    int y2 = parse!int(coords[3]);
    int x3 = parse!int(coords[4]);
    int y3 = parse!int(coords[5]);
    intersection += intersections(x1, y1, x2, y2);
    intersection += intersections(x1, y1, x3, y3);
    intersection += intersections(x2, y2, x3, y3);
    //writeln(intersection);
    //readln();
    if (intersection == 1) total++;
  }
  writeln(total);
}