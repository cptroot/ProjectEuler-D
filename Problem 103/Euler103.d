import std.stdio;

struct SumSet {
  int[] set;
  int size;
  int maxSum;
  
  this(int size, int maxSum) {
    this.size = size;
    this.maxSum = maxSum;
    foreach (i; 0..size) {
      set[i] = i + 1;
    }
  }
  
  @property int sum() {
    int total = 0;
    foreach (i; set)
      total += i;
    
    return total;
  }

  void Iterate() {
    if (sum != maxSum - 1) {
      set[$ - 1]++;
      return;
    }
    
    int i = 2;
    while (i < size && set[$ - i] + 1 == set[$ - i + 1]) i++;
    
    set[$ - i]++;
    foreach (j; 1..i)
      set[$ - i + j] = set[$ - i] + j;
  }

  alias set this;
}

void main() {
  int size = 3;
  int maxSum = 9;
  
  Set set = Set(size, maxSum);
  
  while (!CheckSet(set)) {
    set.Iterate();
  }
  
  writeln(set.set);
}

int[][][] paired_sets = [
  [[0, 1, 2, 3], [0, 2, 1, 3], [0, 3, 1, 2]],
  [
    [0, 1, 2, 3, 4, 5],
    [0, 1, 3, 2, 4, 5],
    [0, 1, 4, 2, 3, 5],
    [0, 1, 5, 2, 3, 4],
    [0, 2, 3, 1, 4, 5],
    [0, 2, 4, 1, 3, 5],
    [0, 2, 5, 1, 3, 4],
    [0, 3, 4, 1, 2, 5],
    [0, 3, 5, 1, 2, 4],
    [0, 4, 5, 1, 2, 3],
  ],
];

bool CheckSet(int[] set) {
  // Check sizes
  foreach (i; 1..(set.length + 1) / 2) {
    if (Sum(set[0..i + 1]) <= Sum(set[$ - i..$])) {
      return false;
    }
  }

  // Check equal size sets.
  foreach (n; 2..set.length / 2) {
    int[] included;
    included.length = n * 2;

    foreach (i; 0..included.length) {
      included[i] = i;
    }
    

    while (1) {
      foreach (indexer; paired_sets[n - 2]) {
        foreach (
      }

      if (included[$ - 1] == set.length - 1)
      int i = 2;
      while (i < size && included[$ - i] + 1 == included[$ - i + 1]) i++;

      if (i == size) continue;
      included[$ - i]++;
      foreach (j; 0..i) 
       included[$ - i + j] = included[$ - i] + j;
    }
  }
}