import std.stdio;
import std.conv;

void main() {
  int i = 1;
  string decimal = "";
  while (decimal.length < 1_000_000) {
    decimal ~= to!string(i);
    i++;
  }
  int num = 1;
  writeln(to!int(decimal[10000 - 1]));
  num *= to!int(decimal[10 - 1] - 48);
  num *= to!int(decimal[100 - 1] - 48);
  num *= to!int(decimal[1000 - 1] - 48);
  num *= to!int(decimal[10000 - 1] - 48);
  num *= to!int(decimal[100000 - 1] - 48);
  num *= to!int(decimal[1000000 - 1] - 48);
  writeln(num);
}