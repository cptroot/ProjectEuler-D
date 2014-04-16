import std.stdio;

class Tree {
  int value;
  Tree parent;
  this(int value, Tree parent) {
    this.value = value;
    this.parent = parent;
  }
}

void main() {
  Tree[] leaves = [new Tree(1, null)];
  bool[] found = new bool[200];
  found[1 - 1] = true;
  int total = 0;
  int numFound = 1;
  int deep = 0;
  while (numFound != 200) {
    writeln(deep++);
    Tree[] newLeaves;
    foreach (leaf; leaves) {
      Tree parent = leaf;
      while (parent !is null) {
        int value = leaf.value + parent.value;
        if (value > 200) {
          parent = parent.parent;
          continue;
        }
        newLeaves ~= new Tree(value, leaf);
        if (!found[value - 1]) {
          found[value - 1] = true;
          numFound++;
          writeln(numFound);
          total += deep;
          if (numFound == 200) break;
          if (total < 0) throw new Exception("Uh Oh");
        }
        parent = parent.parent;
      }
      if (numFound == 200) break;
    }
    leaves = newLeaves;
  }
  writeln(total);
}