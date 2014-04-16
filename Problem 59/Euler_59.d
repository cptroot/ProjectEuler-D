import std.stdio;
import std.file;
import std.array;
import std.conv;

void main() {
  string input = readText("cipher1.txt");
  string[] characters = split(input, ",");
  char[] encrypted;
  foreach (i, value; characters) {
    encrypted ~= parse!int(value);
  }
  char[] password = [97, 97, 97];
  while (1) {
    char[] result;
    bool bad = false;
    foreach (i, value; encrypted) {
      char temp = value ^ password[i%3];
      switch (temp){
        case 'A': .. case 'Z':  case 'a': .. case'z':
          break;
        case ' ': case ',': case '.': case ':': case';': case '\'': case '(': case')': case '!':
          break;
        case '0': .. case '9':
          break;
        default:
          bad = true;
          break;
      }
      if (bad) break;
      result ~= temp;
    }
    if (!bad) {
      writeln(result);
      long total = 0;
      foreach(v; result) {
        total += v;
      }
      writeln(total);
    }
    password[2]++;
    if (password[2] == 123) {
      password[2] = 97;
      password[1]++;
    }
    if (password[1] == 123) {
      password[1] = 97;
      password[0]++;
    }
    if (password[0] == 123) break;
  }
}