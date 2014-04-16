import std.stdio;

void main() {
  bool isLeapYear(int year) {
    return year % 4 == 0 && (year % 100 != 0 || year % 400 == 0);
  }
  int[] days = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
  int year = 1900;
  int month = 0;
  int mod = 1;
  int total = 0;
  while (year < 2001) {
    if (mod == 0 && year > 1900) {
      total++;
    }
    mod += days[month];
    mod %= 7;
    month++;
    if (month == 12) {
      month = 0;
      year++;
      if (isLeapYear(year)) {
        days[1] = 29;
      }
      else {
        days[1] = 28;
      }
    }
  }
  writeln(total);
}