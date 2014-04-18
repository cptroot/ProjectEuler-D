import std.stdio;
import std.algorithm;

immutable int[8] coin_values = [1, 2, 5, 10, 20, 50, 100, 200];

void main() {
  int sum = 0;
  int total = 0;
  
  int[9] coin_counts;
  
  while (coin_counts[8] == 0) {
    int value = calculate_value(coin_counts);
    if (value == 200) total++;
    if (value >= 200) {
      for (int i = 0; i < 8; i++) {
        if (coin_counts[i] > 0) {
          coin_counts[i] = 0;
          coin_counts[i + 1]++;
          break;
        }
      }
    } else {
      coin_counts[0]++;
    }
  }
  writeln(total);
}

int calculate_value(int[] coin_counts) {
  int result = 0;
  for (int i = 0; i < 8; i++) {
    result += coin_values[i] * coin_counts[i];
  }
  return result;
}