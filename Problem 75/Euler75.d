import std.stdio;
import std.typecons;

struct Triple {
  Tuple!(int, int, int) t;
  int k;

  int L() {
    return (t[0] + t[1] + t[2]) * k;
  }
}

void main() {
  int max = 1_500_000;

  Triple[] queue;
  int[int] matches;

  queue ~= Triple(tuple(3, 4, 5), 1);

  Triple front;
  while (queue.length > 0) {
    front = queue[0];
    queue = queue[1..$];

    if (front.t[0] % 10000 == 0) writeln(front);

    matches[front.L]++;

    if (front.k > 1) {
      front.k++;
      if (front.L <= max) queue ~= front;
    } else {
      int L;

      L = 5 * front.t[0] - 5 * front.t[1] + 7 * front.t[2];
      if (L <= max)
        queue ~= Triple(tuple(front.t[0] - 2 * front.t[1] + 2 * front.t[2],
                 2 * front.t[0] - front.t[1] + 2 * front.t[2],
                 2 * front.t[0] - 2 * front.t[1] + 3 * front.t[2]), 1);

      L = 5 * front.t[0] + 5 * front.t[1] + 7 * front.t[2];
      if (L <= max)
        queue ~= Triple(tuple(front.t[0] + 2 * front.t[1] + 2 * front.t[2],
          2 * front.t[0] + front.t[1] + 2 * front.t[2],
          2 * front.t[0] + 2 * front.t[1] + 3 * front.t[2]), 1);

      L = -5 * front.t[0] + 5 * front.t[1] + 7 * front.t[2];
      if (L <= max)
        queue ~= Triple(tuple(-front.t[0] + 2 * front.t[1] + 2 * front.t[2],
          -2 * front.t[0] + front.t[1] + 2 * front.t[2],
          -2 * front.t[0] + 2 * front.t[1] + 3 * front.t[2]), 1);

      L = front.L * 2;
      if (L <= max)
        queue ~= Triple(tuple(front.t[0], front.t[1], front.t[2]), 2);
    }
  }

  int total = 0;

  foreach (i, v; matches) {
    if (v == 1) total++;
  }

  //writeln(matches);

  writeln(total);
}