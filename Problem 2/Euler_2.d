import std.stdio;

void main() {
  auto f1 = 0;
  auto f2 = 1;
  int temp;
  auto parity = 1;
  auto sum = 0;
  do {
    temp = f2;
    f2 += f1;
    f1 = temp;
    if (parity == 3) {
      sum += f1;
      parity = 0;
    }
    parity++;
  } while (f2 < 4_000_000);
  writefln("Total: %s", sum);
}