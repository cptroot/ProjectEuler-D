import std.stdio;
import std.file;
import std.array;
import std.typecons;
import std.conv;

class Tree {
  Tree parent;
  Tree root() {
    auto current = this;
    while (current.parent !is null) {current = current.parent;}
    return current;
  }
}

void main() {
  Tree[] points = new Tree[40];
  foreach (ref tree; points) {
    tree = new Tree();
  }
  int[Tuple!(uint, uint)] edges;
  string[] lines = split(readText("network.txt"), "\r\n");
  int total = 0;
  int numEdges = 0;
  foreach (i, line; lines) {
    if (line == "") continue;
    foreach (j, value; split(line, ",")) {
      if (value == "") continue;
      if (value == "-") continue;
      if (j >= i) continue;
      int num = parse!int(value);
      edges[tuple(i, j)] = num;
      total += num;
    }
  }

  while (numEdges < 39) {
    int min = 1_000;
    Tuple!(uint, uint) minPos;
    foreach (i, value; edges) {
      if (value < min) {
        min = value;
        minPos = i;
      }
    }
    auto root0 = points[minPos[0]].root();
    auto root1 = points[minPos[1]].root();
    if (root0 !is root1) {
      root1.parent = root0;
      total -= min;
      numEdges++;
    }
    edges.remove(minPos);
    writeln(edges.length);
  }
  writeln(total);
}
  