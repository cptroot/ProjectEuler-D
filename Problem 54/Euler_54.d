import std.stdio;
import std.file;
import std.array;
import std.algorithm;

void main() {
  string text = readText("poker.txt");
  string[] lines = split(text, "\n");
  int total;
  int[10] handOne;
  int[10] handTwo;
  foreach (index, line; lines) {
    if (line.length < 3) continue;
    auto values = split(line, " ");
    foreach (i; 0..5) {
      switch (values[i][0]) {
        case '1': .. case '9':
          handOne[i] = values[i][0] - 48;
          break;
        case 'T':
          handOne[i] = 10;
          break;
        case 'J':
          handOne[i] = 11;
          break;
        case 'Q':
          handOne[i] = 12;
          break;
        case 'K':
          handOne[i] = 13;
          break;
        case 'A':
          handOne[i] = 14;
          break;
        default:
          break;
      }
      switch (values[i][1]) {
        case 'H':
          handOne[i + 5] = 0;
          break;
        case 'C':
          handOne[i + 5] = 1;
          break;
        case 'D':
          handOne[i + 5] = 2;
          break;
        case 'S':
          handOne[i + 5] = 3;
          break;
        default:
          break;
      }
      switch (values[i + 5][0]) {
        case '1':..case '9':
          handTwo[i] = values[i + 5][0] - 48;
          break;
        case 'T':
          handTwo[i] = 10;
          break;
        case 'J':
          handTwo[i] = 11;
          break;
        case 'Q':
          handTwo[i] = 12;
          break;
        case 'K':
          handTwo[i] = 13;
          break;
        case 'A':
          handTwo[i] = 14;
          break;
        default:
          break;
      }
      switch (values[i + 5][1]) {
        case 'H':
          handTwo[i + 5] = 0;
          break;
        case 'C':
          handTwo[i + 5] = 1;
          break;
        case 'D':
          handTwo[i + 5] = 2;
          break;
        case 'S':
          handTwo[i + 5] = 3;
          break;
        default:
          break;
      }
    }
    sort(handOne[0..5]);
    sort(handTwo[0..5]);
    if (handIsGreater(handOne, handTwo)) {
      total++;
      writeln(index, handOne, handTwo);
    }
  }
  writeln(total);
}

unittest {
  assert(!handIsGreater([5, 5, 6, 7, 13, 0, 1, 3, 3, 2], [2, 3, 8, 8, 10, 1, 3, 3, 2, 2]));
  assert(isRoyalFlush([10, 11, 12, 13, 14, 2, 2, 2, 2, 2]));
  assert(isFullHouse([2, 2, 5, 5, 5, 1, 2, 3, 1, 1]));
}

bool handIsGreater(int[10] handOne, int[10] handTwo) {
  auto valuesOne = handValues(handOne);
  auto valuesTwo = handValues(handTwo);
  for(int i = 0; i < 6; i++) {
    if (valuesOne[i] > valuesTwo[i]) return true;
    if (valuesOne[i] < valuesTwo[i]) return false;
  }
  return true;
}

int[] handValues(int[10] hand) {
  int[] descending = hand[0..5].dup;
  reverse(descending);
  if (isRoyalFlush(hand)) return [10];
  if (isStraightFlush(hand)) return [9, hand[4]];
  if (isFourOfAKind(hand)) {
    if (hand[0] == hand[1]) return [8, hand[0], hand[4]];
    return [8, hand[4], hand[0]];
  }
  if (isFullHouse(hand)) {
    if (hand[1] == hand[2]) return[7, hand[2], hand[3]];
    return[7, hand[2], hand[1]];
  }
  if (isFlush(hand)) return [6] ~ descending;
  if (isStraight(hand)) return[5, hand[4]];
  if (isThreeOfAKind(hand)) {
    if (hand[0] == hand[1]) return [4, hand[0], hand[4], hand[3]];
    if (hand[1] == hand[2]) return [4, hand[1], hand[4], hand[0]];
    if (hand[2] == hand[3]) return [4, hand[2], hand[1], hand[0]];
  }
  if (isTwoPair(hand)) {
    if (hand[0] == hand[1] && hand[2] == hand[3]) return [3, hand[2], hand[0], hand[4]];
    if (hand[0] == hand[1] && hand[3] == hand[4]) return [3, hand[3], hand[0], hand[2]];
    if (hand[1] == hand[2] && hand[3] == hand[4]) return [3, hand[3], hand[1], hand[0]];
  }
  if (isPair(hand)) {
    int[] result = [2];
    int[] finalHand;
    foreach (i; 0..4) {
      if (hand[i] == hand[i + 1]) {
        result ~= hand[i];
        finalHand = hand[0..i] ~ hand[i+2..$];
        break;
      }
    }
    return result ~ [finalHand[2], finalHand[1], finalHand[0]];
  }
  return [1] ~ descending;
}

bool isRoyalFlush(int[10] hand) {
  //writeln("Royal Flush");
  if (!isFlush(hand)) return false;
  foreach (i; 0..5) {
    if (hand[i] != 10 + i) return false;
  }
  return true;
}

bool isStraightFlush(int[10] hand) {
  //writeln("Straight Flush");
  if (!isFlush(hand)) return false;
  if (!isStraight(hand)) return false;
  return true;
}

bool isFourOfAKind(int[10] hand) {
  //writeln("Four Of a Kind");
  if (hand[0] == hand[1]) {
    if (hand[1] != hand[2]) return false;
    if (hand[2] != hand[3]) return false;
  }
  else {
    if (hand[1] != hand[2]) return false;
    if (hand[2] != hand[3]) return false;
    if (hand[3] != hand[4]) return false;
  }
  return true;
}

bool isFullHouse(int[10] hand) {
  //writeln("Full House");
  if (hand[0] != hand[1] || hand[3] != hand[4]) return false;
  if (hand[2] != hand[1] && hand[2] != hand[3]) return false;
  return true;
}

bool isFlush(int[10] hand) {
  //writeln("Flush");
  int value = hand[5];
  foreach (i; 6..10) {
    if (value != hand[i]) return false;
  }
  return true;
}

bool isStraight(int[10] hand) {
  //writeln("Straight");
  int start = hand[0];
  foreach (i; 1..5) {
    if (hand[i] != start + i) return false;
  }
  return true;
}

bool isThreeOfAKind(int[10] hand) {
  foreach (i; 0..3) {
    if (hand[i] == hand[i + 1] && hand[i + 1] == hand[i + 2]) return true;
  }
  return false;
}

bool isTwoPair(int[10] hand) {
  int count = 0;
  foreach (i; 0..4) {
    if (hand[i] == hand[i + 1]) count++;
  }
  if (count == 2) return true;
  return false;
}

bool isPair(int[10] hand) {
  foreach (i; 0..4) {
    if (hand[i] == hand[i + 1]) return true;
  }
  return false;
}