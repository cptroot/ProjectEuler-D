import std.stdio;
import std.conv;
import std.math;

void main() {
  int total = 0;

  int length = 1_500_000;

  float divFactor = 2 + sqrt(2f);
  
  foreach (int L; 3..length + 1) {
    int matches = 0;
    if (L % 10_000 == 0) writeln(L);

    int a = cast(int)floor((sqrt(1 + 4 * cast(float)L) - 1) / 2);
    int a2 = a*a;
    int b = L - (L * L) / (2 * L - 2 * a);
    
    int max = cast(int)ceil(L / divFactor) + 1;
    while (a < max) {
      int c = L - a - b;
      //writeln(L, " ", a, " ", b, " ", c);
      while (matches < 2 && a2 + b*b <= c*c) {
        //writef("%d, %d, %d\n", a, b, c);
        b++;
        c--;
      }
      if (a2 + b* b == c * c) {
        matches++;
        //writef("Match %d: %d, %d, %d\n", L, a, b, c);
      }
      
      if (matches > 1) break;

      a++;
      a2 += 2 * a - 1;
      b--;
    }
    if (matches == 1) total++;
  }
  writeln(total);
}

// a*a + b*b = (L - a - b) * (L - a - b)
// &= L*L - 2aL -2bL + a * b + b * b + 2ab
//2aL + 2bL &= L*L + 2ab
//b ( 2L - 2a) &= L * L - 2aL
// b = (L * L - 2aL) / (2L - 2a)
// &= L - (L * L) / (2L - 2a)

// a * a + n * n = (n + 1) * (n + 1)
// a * a = 2* n + 1
// a + 2 * n + 1 = L
// a + a * a = L
// a * a + a - L = 0
// a = (-1 + sqrt(1 + 4 * L) ) / 2