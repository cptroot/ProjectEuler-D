import std.stdio;
import std.math;
import std.bigint;

struct remainder {
  real n, a, b, c;
}

int[] sqrtContinuedFraction(int n) {
  real x = sqrt(cast(float)n);
  remainder[] r = [remainder(n, 1, 0, 1)];
  int[] a = [cast(int)floor(x)];

  real d;
  while (a[$ - 1] != a[0] * 2) {
    d = r[$ - 1].c * a[$ - 1] - r[$ - 1].b;
    r ~= remainder(n, r[$ - 1].a, d, (n * r[$ - 1].a * r[$ - 1].a - d * d) / r[$ - 1].c);
    a ~= cast(int)floor((x * r[$ - 1].a + r[$ - 1].b) / r[$ - 1].c);
  }

  return a;
}

void main() {
  int maxD = 0;
  BigInt maxX = 0;

  int max = 1000;

  int sqr = 2;

  foreach (D; 2..max) {
    if (D == sqr * sqr) {
      sqr++;
      continue;
    }

    auto a = sqrtContinuedFraction(D);

    BigInt[] p = [BigInt(a[0]), BigInt(a[0] * a[1] + 1)];

    int r = cast(int)a.length - 2;
    int index = r % 2 == 0 ? 2 * r + 1 : r;
    foreach (i; 2..index + 1) {
      int temp = i >= a.length ? a[(i - 1) % (a.length - 1) + 1] : a[i];
      p ~= temp * p[$ - 1] + p[$ - 2];
    }

    if (p[index] > maxX) {
      maxX = p[index];
      maxD = D;
    }
  }
  writeln(maxD);
}