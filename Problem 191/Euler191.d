import std.stdio;

void main() {
  int day = 0;
  int[21][30] absences;

  absences[0][0] = 1;
  absences[1][1] = 1;
  absences[2][2] = 1;

  int limit = 30;

  while (day < limit) {
    foreach (absence, number; absences[day]) {
      if (number == 0) continue;
      if (day < limit - 3)
        absences[day + 3][absence + 2] += number;
      if (day < limit - 2)
        absences[day + 2][absence + 1] += number;
      if (day < limit - 1)
        absences[day + 1][absence] += number;
      if (day == limit - 3)
        absences[day + 2][absence + 2] += number;
      if (day == limit - 2)
        absences[day + 1][absence + 1] += number;
    }
    day++;
  }

  int total = 0;

foreach (absence; absences) {
  writeln(absence);
}


  foreach (absence, number; absences[limit - 1]) {
    total += number * (limit - absence + 1);
  }

  writeln(total);
}