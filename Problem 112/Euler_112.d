import std.stdio;
import std.math;
import std.conv;

int[] toArray(int n) {
  int[] result;
  int index = 0;
  while (n != 0) {
    int mod = n % 10;
    result ~= mod;
    n -= mod;
    n /= 10;
  }
  return result;
}

bool increasing(int[] nArr) {
 foreach (i; 0..nArr.length - 1) {
   if (nArr[i] > nArr[i + 1]) {
     return false;
   }
 }
 return true;
}

bool decreasing(int[] nArr) {
  foreach (i; 0..nArr.length - 1) {
   if (nArr[i] < nArr[i + 1]) {
     return false;
   }
 }
 return true;
}

void main() {
  int bouncy;
  int total;
  do {
    int[] nArr;
    foreach (n; total * 100 + 1..(total + 1) * 100 + 1) {
      nArr = toArray(n);
      if (nArr.length < 3) continue;
      if (!increasing(nArr) && !decreasing(nArr)) bouncy++;
    }
    total++;
    //if (total * 100 > 21780) throw new Exception("WTF?" ~ to!string(total * 10) ~ " " ~ to!string(bouncy));
  } while (bouncy != total * 99);
  writeln(total * 100);
}