import std.stdio;
import std.math;
import std.bigint;
import std.conv;
import std.typecons;

import rbtree;

alias Tuple!(uint, BigInt) pair;

bool comparison(pair a, pair b) {
  if (a[1] != b[1]) return a[1] < b[1];
  else return a[0] < b[0];
}

alias RBTree!(comparison, pair) Tree;

int sum(BigInt n) {
  string str;
  n.toString((const(char)[] inStr) {str = to!string(inStr);}, "d");
  int result = 0;
  foreach (c; str) {
    result += c - 48;
  }
  return result;
}

void main() {
  BigInt[] powers = new BigInt[10000];
  powers[0] = BigInt(4);
  long[] indexes = new long[10000];
  indexes[0] = 2L;
  BigInt[] initial = new BigInt[10000];
  initial[0] = BigInt(2);
  Tree queue = new Tree(tuple(0u, BigInt(4)));
  int index = 0;
  BigInt value = 0;
  while (index != 30) {
    Tree least = queue.least;
    uint min = least.value[0];
    BigInt minValue = least.value[1];
    if (queue.children[0] !is null || queue.children[1] !is null) {
      queue.remove(least.value);
    } else queue = null;
    
    if (indexes[min] == 2) {
      if (min + 1 >= powers.length) {
        writeln(powers.length + 10000);
        powers ~= new BigInt[10000];
        indexes ~= new long[10000];
        initial ~= new BigInt[10000];
      }
      powers[min + 1] = BigInt(min+3) * BigInt(min + 3);
      indexes[min + 1] = 2;
      initial[min + 1] = BigInt(min + 3);
      if (queue is null) queue = new Tree(tuple(min + 1, powers[min + 1]));
      else queue.insert(tuple(min + 1, powers[min + 1]));
    }

    if (BigInt(sum(powers[min])) == initial[min]) {
      index++;
      value = powers[min];
      writeln(index, " ", powers[min]);
    }

    indexes[min]++;
    powers[min] *= initial[min];
    if (queue is null) queue = new Tree(tuple(min, powers[min]));
    else queue.insert(tuple(min, powers[min]));
    //if (powers[min] < 0) throw new Exception("WTF?");
    //queue.display();
    //readln();
  }
  writeln(value);
}