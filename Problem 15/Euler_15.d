import std.stdio;

void main() {
  long[21][21] binomialGrid;

  long Binomial(int n, int k) {
    if (k == 0 || n == 0)
      return 1;
    if (binomialGrid[n][k] != 0) {
      return binomialGrid[n][k];
    }
    binomialGrid[n][k] = Binomial(n - 1, k) + Binomial(n, k - 1);
    return binomialGrid[n][k];
  }
  writeln(Binomial(20, 20));
}