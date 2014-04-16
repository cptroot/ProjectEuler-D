import std.stdio;
import std.algorithm;

int[] generatePolygons(int firstTwo, int previousNumber, bool[] remainingNumbers, bool[][] polygonal) {
  int lastTwo = previousNumber % 100;
  if (lastTwo < 10) return null;
  foreach (i, value; remainingNumbers) {
    if (!value) continue;
    foreach (j; 0..100) {
      //writeln(i, " ", lastTwo * 100 + j);
      //writeln(polygonal[i - 3].length);
      if (!polygonal[i - 3][lastTwo * 100 + j - 1000]) continue;
      remainingNumbers[i] = false;
      writeln(i, " = ", lastTwo * 100 + j);
      if (reduce!((a, b) {return a + b;})(0, remainingNumbers) == 0) {
        if (firstTwo / 100 != j) {
          writeln(firstTwo / 100, " ", j);
          remainingNumbers[i] = true;
          continue;
        }
        return [lastTwo * 100 + j];
      }
      int[] result = generatePolygons(firstTwo, lastTwo * 100 + j, remainingNumbers, polygonal);
      if (result.length != 0) {
        return lastTwo * 100 + j ~ result;
      }
      remainingNumbers[i] = true;
    }
  }
  return null;
}

int[] generatePolygons(bool[][] polygonal) {
  bool[] remainingNumbers = [false, false, false, true, true, true, true, true, false];
  foreach (i, value; polygonal[5]) {
    if (!value) continue;
    writeln("8 = ", i + 1000);
    int[] result = generatePolygons(i + 1000 - i % 100, i + 1000, remainingNumbers, polygonal);
    if (result.length == 0) continue;
    return i + 1000 ~ result;
  }
  return null;
}

void main() {
  bool[][] polygonal;
  foreach (i; 3..9) {
    bool[] polygon = new bool[10_000 - 1_000];
    polygon[] = false;
    int next = 1;
    int n = 1;
    while (next < 1_000) {
      n++;
      next = ((i - 2) * n * n + (4 - i) * n) / 2;
    }
    foreach (j; 1_000..10_000) {
      if (j != next) {
        continue;
      }
      polygon[j - 1_000] = true;
      n++;
      next = ((i - 2) * n * n + (4 - i) * n) / 2;
    }
    polygonal ~= polygon;
  }
  writeln(polygonal.length);
  int[] result = generatePolygons(polygonal);
  writeln(reduce!("a + b")(0, result));
}
  