import std.stdio;
import std.math;
import std.conv;

void main() {
  Node tree;
  Node[] ordered;
  tree = new Node(1, 0);
  ordered ~= tree;

  int n = 1;
  bool running = true;

  int object = 20;
  int number = 0;

  double minX = double.max;

  bool[6] lefts;

  foreach (i; 0..6) {
    foreach (j; i + 1..6) {
      foreach (k; j + 1..6) {
        lefts[] = false;
        lefts[i] = true;
        lefts[j] = true;
        lefts[k] = true;
        Node node = new Node(1, 0);
        foreach (left; lefts) {
          if (left) {
            node = new Node(node.a, node.b + node.x);
          } else {
            node = new Node(node.a + node.x, node.b);
          }
        }
        if (node.x < minX) minX = node.x;
      }
    }
  }

  while (running) {
    if (n < 0) { writeln("oops"); break; }
    if (n % 10000 == 0) writeln(n);
    Node node = ordered[0];
    ordered = ordered[1..$];

    if (node.leftIndex == 3 && node.belowIndex == 3) {
      writeln(node.a, ", ", node.b, ": ", n, ", ", node.lefts);
      number++;
      if (number == object) { writeln(n); break; }
    }

    Node l = new Node(node.a, node.b + node.x);
    Node r = new Node(node.a + node.x, node.b);
    l.leftIndex = node.leftIndex;
    l.belowIndex = node.belowIndex + 1;
    r.leftIndex = node.leftIndex + 1;
    r.belowIndex = node.belowIndex;

    l.lefts = node.lefts ~ true;
    r.lefts = node.lefts ~ false;
    int index = 0;
    if (minX <= l.x) {
      foreach (i, temp; ordered) {
        if (l.x < temp.x) { index++; continue; }
        index = i;
        break;
      }
      ordered = ordered[0..index] ~ l ~ ordered[index..$];
    }
    index = 0;
    //writeln(ordered);
    if (minX <= r.x) {
      foreach (i, temp; ordered) {
        if (r.x < temp.x) { index++; continue; }
        index = i;
        break;
      }
      ordered = ordered[0..index] ~ r ~ ordered[index..$];
    }
    n++;
    //writeln(ordered);
    //readln();
  }
}

class Node {
  double a;
  double b;
  double x;
  int leftIndex;
  int belowIndex;
  Node left;
  Node right;

  bool[] lefts;

  this(double a, double b) {
    this.a = a;
    this.b = b;
    x = -(a + b) + sqrt((a - b) * (a - b) + 4);
    x /= 2.0;
  }

  string toString() {
    return to!string(leftIndex) ~ ", " ~ to!string(belowIndex) ~ ": " ~ to!string(x);
  }
}