import std.stdio;
import std.bigint;
import std.conv;

void main() {
  int limit = 101;
  BigInt[][] pascal = new BigInt[][limit];
  foreach (i; 0..limit) {
    pascal[i] = new BigInt[limit - i];
  }
  foreach(i; 0..limit) {
    pascal[0][i] = 1;
  }
  int total = 0;
  foreach (i; 1..limit) {
    writeln(i);
    pascal[i][0] = 1;
    foreach(j; 1..limit - i) {
      pascal[i][j] = pascal[i][j - 1] + pascal[i - 1][j];
      if (pascal[i][j] > 1_000_000) total++;
    }
    writeln(pascal[i]);
  }
  writeln(total);
}