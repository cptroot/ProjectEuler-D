import std.stdio;
import std.algorithm;

void main() {
  int max = 12000;

  int[] minimumPS = new int[max];
  int completed = 1;
  minimumPS[0] = 4;

  int[][] queue;

  queue ~= [2, 2];

  int[] front;

  while (completed < max - 1 && queue.length > 0) {
    front = queue[0];
    queue = queue[1..$];
    int k;

    foreach (i; 0..front.length) {
      if ((i > 0 && front[i] == front[i - 1]) || (i < front.length - 1 && front[i + 1] != 2)) continue;
      
      front[i]++;

      int m = mult(front);

      k = m - sum(front) + cast(int)front.length;
      if (k > max || k < front.length) { front[i]--; continue; }
      if (minimumPS[k - 2] == 0) {
        //writeln(k, " ", m, " ", front);
        minimumPS[k - 2] = m;
        completed++;
      } //else writeln(k, " ", m, " ", front, " R");

      queue ~= front.dup;

      front[i]--;
    }

    if (front[0] > 2) continue;
    front ~= 2;
    k = mult(front) - sum(front) + cast(int)front.length;
    if (k > max || k < front.length) continue;
    if (minimumPS[k - 2] == 0) {
      //writeln(k, " ", mult(front), " ", front);
      minimumPS[k - 2] = mult(front);
      completed++;
    } //else writeln(k, " ", mult(front), " ", front, " R");

    queue ~= front.dup;
  }

  int[] unique;
  int total;
  foreach (n; minimumPS) {
    if (!canFind(unique, n)) {
      total += n;
      unique ~= n;
    }
  }

  writeln(total);
}

bool satisfies(int[] l) { return mult(l) == sum(l); }

int mult(int[] l) { return reduce!("a * b")(1, l); }
int sum(int[] l) { return reduce!("a + b")(0, l); }