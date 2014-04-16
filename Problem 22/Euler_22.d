import std.stdio;
import std.file;
import std.array;

void QuickSort(string[] sortArray) {
  if (sortArray.length == 0) return;
  string swapString;
  int pivotIndex = sortArray.length / 2;
  string pivotValue = sortArray[pivotIndex];
  swapString = sortArray[pivotIndex];  // Move pivot to end
  sortArray[pivotIndex] = sortArray[$ - 1];
  sortArray[$ - 1] = swapString;
  int swapIndex = 0;
  foreach (i; 0..sortArray.length - 1) { // left <= i < right
    if (sortArray[i] < pivotValue) {
      if (i != swapIndex) {
        swapString = sortArray[i];
        sortArray[i] = sortArray[swapIndex];
        sortArray[swapIndex] = swapString;
      }
      swapIndex++;
    }
  }
  swapString = sortArray[$ - 1];
  sortArray[$ - 1] = sortArray[swapIndex];
  sortArray[swapIndex] = swapString; // Move pivot to its final place
  QuickSort(sortArray[0..swapIndex]);
  QuickSort(sortArray[swapIndex+1..$]);
}

void main() {
  string[] names = split(readText("names.txt")[1..$-1], "\",\"");
  writeln(names[0..20]);
  QuickSort(names);
  long total = 0;
  int value = 0;
  foreach(i, name;names) {
    value = 0;
    foreach(c;name) {
      value += c - 64;
    }
    value *= i + 1;
    total += value;
    if (i == 937) writeln(value);
  }
  writeln(total);
}