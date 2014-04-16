import std.stdio;
import std.random;
import std.math;

bool closeEnough(double[40] a, double[40] b) {
  foreach (i; 0..40) {
    if (abs(a[i] - b[i]) > .00000001) return false;
  }
  return true;
}

void main() {
  int roll = 1;
  int position = 0;
  int[40] freq;
  double num = 0;
  double[40] oldProb = new double[40];
  double[40] newProb = new double[40];
  foreach (i; 0..40) {
    freq[i] = 0;
    oldProb[i] = 0;
    newProb[i] = 0;
  }
  newProb[0] = 1;
  int run = 1;
  while (!closeEnough(oldProb, newProb)) {
    writeln(run++);
    oldProb = newProb.dup;
    foreach (i; 0..1000) {
      roll = 0;
      roll += uniform(1, 5);
      roll += uniform(1, 5);
      position += roll;
      position %= 40;
      int card = 0;
      switch (position) {
        case 2, 17, 33:
          card = uniform(1, 17);
          if (card == 1) position = 0;
          if (card == 2) position = 10;
          break;
        case 7, 22, 36:
          card = uniform(1, 17);
          switch (card) {
            case 1:
              position = 0;
              break;
            case 2:
              position = 10;
              break;
            case 3:
              position = 11;
              break;
            case 4:
              position = 24;
              break;
            case 5:
              position = 39;
              break;
            case 6:
              position = 5;
              break;
            case 7, 8:
              if (position == 7) position = 15;
              if (position == 22) position = 25;
              if (position == 36) position = 5;
              break;
            case 9:
              if (position == 7) position = 12;
              if (position == 22) position = 28;
              if (position == 36) position = 12;
              break;
            case 10:
              position -= 3;
              position %= 40;
              break;
            default: break;
          }
          break;
        case 30:
          position = 10;
          break;
        default: break;
      }
      freq[position]++;
    }
    num += 10000;
    foreach (i; 0..40) {
      newProb[i] = freq[i];
    }
    foreach (ref i; newProb) {
      i /= num;
    }
  }
  foreach (i; 0..40) {
    writeln(i, ": ", newProb[i]);
  }

  double max1, max2, max3 = 0;
  int int1, int2, int3;
  foreach (i; 0..40) {
    if (newProb[i] <= max1) continue;
    max1 = newProb[i];
    int1 = i;
  }
  foreach (i; 0..40) {
    if (newProb[i] <= max2 || i == int1) continue;
    max2 = newProb[i];
    int2 = i;
  }
  foreach (i; 0..40) {
    if (newProb[i] <= max3 || i == int1 || i == int2) continue;
    max3 = newProb[i];
    int3 = i;
  }
  writeln(int1, " ", int2, " ", int3);
}