import std.stdio;
import std.math;
import std.bigint;
import std.conv;
import std.typecons;

import rbtree;

struct Power {
  uint base;
  uint exponent;
  BigInt value;

  Power(uint base, uint exponent, BigInt value)
  
  Power raise() {
    Power result = this;
    result.base = base;
    result.exponent = exponent;
    value = value * base;
  }

  int opCmp(ref const Power p) const {
    return value.opCmp(p.value);
  }
}

void main() {
  auto queue = RBTree!("a < b", Power)(Power(2, 2, Bigint(4)));
  
  foreach(i; queue) {
    writeln(i);
  }
}