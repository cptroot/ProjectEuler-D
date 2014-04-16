import std.stdio;
import std.algorithm;
import std.conv;

class Pentagon {
  long[] pentagons;
  long max;
  uint batch = 1000;
  
  this(uint batch) {
    this.batch = batch;
    ExtendPentagons();
    write("max = ", max);
    readln();
  }
  
  bool isPentagonal(long num) {
    while (num > max) {
      ExtendPentagons();
    }//line 20
    return pentagons.canFind(num);
  }
 
  long Pentagons(uint index) {
    while (index >= pentagons.length) {
      ExtendPentagons();
    }
    return pentagons[index];
  }

  private void ExtendPentagons() {
    foreach (long i; pentagons.length..pentagons.length + batch) {
      pentagons ~= i * (3 * i - 1) / 2;
      if (pentagons[to!uint(i)] < 0) {
        writeln(i - 1);
        readln();
      }
    }
    max = pentagons[$ - 1];
  }
}
    

void main() {
  int[] ns = [0, 1];
  long[] diffs = [0, 4];
  Pentagon p = new Pentagon(1000);
  
  int i = 0;
  long d;
  while (1) {
    i++;
    d = p.Pentagons(i);
    writeln(d);
    if (i == 0) continue;
    foreach (k, ref n; ns) {
      if (k == 0) continue;
      while (diffs[k] < d) {
        if (n == 1) {
          ns ~= 1;
          diffs ~= 3 * (k + 1) + p.Pentagons(k + 1);
        }
        n++;
        diffs[k] = 3 * n * (k) + p.Pentagons(k);
      }
      if (diffs[k] == d) {
        if (p.isPentagonal(p.Pentagons(n + k) + p.Pentagons(n))) {
          writeln(d);
          return;
        }
      }
    }
  }
}
