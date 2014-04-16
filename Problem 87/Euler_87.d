import std.stdio;

import sieve;
import rbtree;

void main() {
  int total = 1;
  int[] sieve = ShortenSieve(Sieve(8_000));
  int a, b, c;
  int asqr, bcube;
  RBTree tree = new RBTree(28);
  foreach (i; 0..908) {
    a = sieve[i];
    asqr = a*a;
    foreach (j; 0..1000) {
      b = sieve[j];
      bcube = b*b*b;
      if (asqr + bcube >= 50_000_000 - 16) break;
      foreach (k; 0..900) {
        c = sieve[k];
        int num = asqr + bcube + c*c*c*c;
        if (num >= 50_000_000) break;
        if (!tree.canFind(num)) {
          tree.insert(num);
          total++;
        }
      }
    }
  }
  //tree.write();
  writeln(total);
}