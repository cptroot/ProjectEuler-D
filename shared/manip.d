import std.math;
import std.stdio;

int[] toArray(size_t i) {
  if (i == 0) return [0];
  return toArray(i, cast(int)(floor(log10(i)) + 1));
}

int[] toArray(size_t i, int length) {
  int[] result;
  result.length = length;
  foreach (j; 0..result.length) {
    result[$ - 1 - j] = i % 10;
    i -= result[$ - 1 - j];
    i /= 10;
  }
  return result;
}

void toArray(size_t i, size_t[] buffer) {
  toArray(i, cast(int)(floor(log10(i)) + 1), buffer);
}

void toArray(size_t i, int length, size_t[] buffer) {
  if (buffer.length != length)
    buffer.length = length;
  foreach (j; 0..length) {
    buffer[$ - 1 - j] = i % 10;
    i -= buffer[$ - 1 - j];
    i /= 10;
  }
}
    
int toInt(int[] arr) {
  if (arr.length == 1) return arr[0];
  return 10 * toInt(arr[0..$ - 1]) + arr[$ - 1];
}