import std.stdio;
import std.file;
import std.array;
import std.algorithm;
import std.string;
import std.conv;
import std.typecons;
import std.math;

void main() {
  string input = readText("words.txt");
  string[] words = split(removechars(input, "\""), ",");

  LetterList l = new LetterList();

  int maxLength = 0;

  char[] temp;
  temp = words[0].dup;
  temp.sort;

  foreach (word; words) {
    temp = word.dup;
    temp.sort;
    l.AddString(word, temp);
    if (word.length > maxLength) maxLength = word.length;
  }

  int maxSquare = 0;

  foreach (anagrams; l) {
    if (anagrams[0].length < 2) continue;
    writeln(anagrams[1], ": ", anagrams[0]);

    int length = anagrams[0][0].length;
    
    string word = anagrams[0][0];
    int minSqr = to!int(ceil(sqrt(pow(10, length - 1))));
    int maxSqr = to!int(ceil(sqrt(pow(10, length))));

    int[] squares;

    int[char][] keys;
    foreach (n; minSqr..maxSqr) {
      int sqr = n * n;
      int[char] key;
      bool bad = false;
      foreach (i; 0..length) {
        if (word[$ - i - 1] in key) {
          if (key[word[$ - i - 1]] != sqr % 10) {
            bad = true;
            break;
          }
          sqr -= sqr % 10;
          sqr /= 10;
        } else {
          int index = countUntil(key.values, sqr % 10);
          if (index != -1) {
            bad = true;
            break;
          }
          key[word[$ - i - 1]] = sqr % 10;
          sqr -= sqr % 10;
          sqr /= 10;
        }
      }
      if (!bad) { squares ~= n; keys ~= key; }
    }

    bool leading = false;

    foreach (i, key; keys) {
      int square = 0;
      foreach (j, c; anagrams[0][1]) {
        if (j == 0 && key[c] == 0) {leading = true; break; }
        square *= 10;
        square += key[c];
      }
      if (!leading && sqrt(square) == floor(sqrt(square))) {
        writeln(squares[i], " ", squares[i] * squares[i], ": ",sqrt(square), " ", square);
        if (square > maxSquare) maxSquare = square;
        if (squares[i] * squares[i] > maxSquare) maxSquare = squares[i] * squares[i];
      }
    }
  }
  writeln(maxSquare);
}

class LetterList {
  LetterList[26] subLists;
  string[] words;
  string anagram;
  Tuple!(string[], string) temp;

  void AddString(string name, char[] s) {
    if (subLists[s[0] - 65] is null) subLists[s[0] - 65] = new LetterList();
    subLists[s[0] - 65].AddString(name, s, 1);
  }

  void AddString(string name, char[] s, int index) {
    if (index == s.length) {
      words ~= name;
      anagram = to!string(s);
    } else {
      if (subLists[s[index] - 65] is null) subLists[s[index] - 65] = new LetterList();
      subLists[s[index] - 65].AddString(name, s, index + 1);
    }
  }

  int opApply(int delegate(ref Tuple!(string[], string)) dg) {
    int result;
    if (words.length != 0) {
      temp = tuple(words, anagram);
      result = dg(temp);
    }
    if (result) return result;
    foreach (list; subLists) {
      if (list is null) continue;
      result |= list.opApply(dg);
      if (result) return result;
    }
    return result;
  }
}