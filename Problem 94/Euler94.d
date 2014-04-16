import std.stdio;

const maximum = 1_000_000_000L;

void main() {
  long total_perimeter = 0;
  
  long sq = 0;
  long area;
  for (long n = 2; 6 * n - 2 < maximum; n++) {
    area = (3 * n - 1) * (n - 1);
    while (sq * sq < area) sq++;
    
    if (sq * sq == area)
      total_perimeter += 6 * n - 2;
  }
  
  sq = 0;
  for (long n = 1; 6 * n + 2 < maximum; n++) {
    area = (3 * n + 1) * (n + 1);
    while (sq * sq < area) sq++;
    
    if (sq * sq == area)
      total_perimeter += 6 * n + 2;
  }
  writeln(total_perimeter);
}