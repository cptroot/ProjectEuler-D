import std.stdio;
import std.conv;
import std.algorithm;

import sieve;

void Rotate(ref string inString) {
  char temp = inString[0];
  string result = inString[1..$];
  inString = result ~ temp;
}

void main() {
  //sieve[0] = 2
  bool[] sieve = Sieve(1_000_000);
  bool[] circular = new bool[sieve.length];
  foreach (i, value; circular) {
    if (value == true) continue;
    string start = to!string(i + 2);
    string temp = start;
    bool isCircular = true;
    do {
      if (sieve[to!int(temp) - 2]) {
        isCircular = false;
        break;
      }
      Rotate(temp);
    } while (temp != start);
    if (isCircular) {
      do {
        circular[to!int(temp) - 2] = true;
        Rotate(temp);
      } while (temp != start);
    }
  }
  writeln(reduce!( (a, b) {return a + b;})(0, circular));
}