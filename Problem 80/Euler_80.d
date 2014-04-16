import std.stdio;
import std.math;
import std.conv;
import std.bigint;

void main() {
  int limit = 1000;
  BigInt[] pow5;
  BigInt prev = 1;
  BigInt mult1 = 5;
  BigInt mult2 = 10;
  int overall = 0;
  foreach (i; 0..limit) {
    prev *= mult2;
  }
  foreach (i; 0..limit) {
    prev *= mult1;
    prev /= mult2;
    pow5 ~= prev;
  }
  int floorN = 0;
  foreach (n; 2..100) {
    if (sqrt(n) == round(sqrt(n))) continue;
    int offset = to!(int)(floor(log2(n))) / 2;
    int sqroffset = offset * 2;
    byte[] x = new byte[limit + offset + 1];
    x[0] = 1;
    byte[] sqr = new byte[limit * 2 + sqroffset + 1];
    byte[] temp = new byte[limit * 2 + sqroffset + 1];
    byte[] nbin = new byte[sqroffset + 1];

    int ntemp = n;
    for (int j = sqroffset; j >= 0; j--){
      int p = pow(2, j);
      while (ntemp >= p) {
        ntemp -= p;
        nbin[sqroffset - j]++;
      }
    }

    sqr[0] = 1;
    foreach (d; -offset + 1..limit + 1) {
      temp = sqr.dup;
      temp[d - 1 + offset..2 * d - 1 + sqroffset] += x[];
      temp[sqroffset + d * 2]++;
      for (int i = sqroffset + d * 2; i > 0; i--) {
        if (temp[i] >= 2) {
          temp[i] -= 2;
          temp[i - 1]++;
        }
      }
      bool bad = true;
      foreach (i; 0..nbin.length) {
        if (temp[i] < nbin[i]) {
          bad = false;
          break;
        }
        if (temp[i] == nbin[i]) continue;
        break;
      }
      if (!bad) {
        x[d + offset] = 1;
        sqr = temp;
      }
    }
    BigInt sum = 0;
    foreach (i; 0..limit) {
      if (x[i + offset + 1] == 0) continue;
      sum += pow5[i];
    }

    int length = to!int(floor(log10(n))) / 2 + 1;
    while ((floorN + 1) * (floorN + 1) < n) floorN++;
    int total = floorN;

    string bigInt;
    sum.toString(delegate void (const (char)[] s) {bigInt = to!string(s);}, "d");
    writeln(to!string(total) ~ "." ~ bigInt[0..100]);
    foreach(i; 0..bigInt.length - limit + 100 - length) {
      total += bigInt[i] - 48;
    }
    overall += total;
    writeln(n, " ", total);
  }
  writeln(overall);
}