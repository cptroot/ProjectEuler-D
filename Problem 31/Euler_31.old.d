import std.stdio;

void main() {
  int sum = 0;
  int total = 0;
  foreach (p1; 0..201) {
    sum += p1;
    foreach (p2; 0..(200 - sum) / 2 + 1) {
      sum += p2*2;
      foreach (p5; 0..(200 - sum) / 5 + 1) {
        sum += p5 * 5;
        foreach (p10; 0..(200 - sum) / 10 + 1) {
          sum += p10 * 10;
          foreach (p20; 0..(200 - sum) / 20 + 1) {
            sum += p20 * 20;
            foreach (p50; 0..(200 - sum) / 50 + 1) {
              sum += p50 * 50;
              foreach (p100; 0..(200 - sum) / 100 + 1) {
                sum += p100 * 100;
                foreach (p200; 0..(200 - sum) / 200 + 1) {
                  sum += p200 * 200;
                  if (sum == 200) total++;
                  sum -= p200 * 200;
                }
                sum -= p100 * 100;
              }
              sum -= p50 * 50;
            }
            sum -= p20 * 20;
          }
          sum -= p10 * 10;
        }
        sum -= p5 * 5;
      }
      sum -= p2 * 2;
    }
    sum -= p1;
  }
  writeln(total);
}