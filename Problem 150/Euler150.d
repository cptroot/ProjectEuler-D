import std.stdio;

const int side = 1000;
const int length = side * (side + 1) / 2;

void main() {
  int t = 0;
  // Constants for the LCG algorithm (linear congruential generator)
  // 2^20, 2^19
  int twenty = 1048576;
  int nineteen = 524288;

  int[] s;
  s.length = length;

  for (int i = 0; i < length; i++) {
    t = 615949 * t + 797807;
    t %= twenty;
    s[i] = t - nineteen;
  }

  //s = [15, -14, -7, 20, -13, -5, -3, 8, 23, -26, 1, -4, -5, -18, 5, -16, 31, 2, 9, 28, 3];

  int x_0 = 0;
  int y_0 = 0;
  int x_1 = side - 1;

  int sum_left, sum_right, sum_bottom;
  int max_value;
  int i;

  while (1) {
    sum_left = 0;
    sum_right = 0;
    sum_bottom = 0;
    for (i = 0; i + x_0 <= x_1; i++) {
      sum_left += s[pos(i + x_0, y_0)];
      sum_right += s[pos(i + x_0, i + y_0)];

      sum_bottom += s[pos(x_1, i + y_0)];
    }

    //writef("x0:%d, y0:%d, x1:%d\n", x_0, y_0, x_1);
    //writef("l, r, b: %d, %d, %d\n", sum_left, sum_right, sum_bottom);
    //readln();

    if (sum_left < 0 && sum_right < 0 && sum_bottom < 0) break;
    max_value = max(sum_left, sum_right, sum_bottom);

    switch (max_value) {
      case sum_left:
        y_0++;
        x_0++;
        break;
      case sum_right:
        x_0++;
        break;
      case sum_bottom:
        x_1--;
        break;
      default:
        break;
    }
  }

  int final_sum = 0;

  for (i = 0; i + x_0 <= x_1; i++) {
    for (int j = 0; j <= i; j++) {
      final_sum += s[pos(x_0 + i, y_0 + j)];
    }
  }

  writeln(final_sum);
}

int pos(int x, int y) {
  return x * (x + 1) / 2 + y;
}

int max(int a, int b, int c) {
  if (a > b)
    if (a > c)
      return a;
    else
      return c;
  else
    if (b > c)
      return b;
    else
      return c;
}