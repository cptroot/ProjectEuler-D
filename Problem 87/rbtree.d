import std.stdio;
import std.typecons;
import std.conv;

class RBTree {
  RBTree parent;
  int value;
  bool black = false;
  Tuple!(RBTree, RBTree) children;
  this(int value) {this.value = value; this.black = true;}
  this(int value, RBTree parent) {
    this.value = value;
    this.parent = parent;
  }

  @property RBTree sibling() {
    if (parent is null) return null;
    if (isLeftChild()) return parent.children[1];
    return parent.children[0];
  }
  
  @property RBTree grandparent() {
    if (parent is null) return null;
    return parent.parent;
  }
  
  @property RBTree uncle() {
    if (grandparent is null) return null;
    return parent.sibling;
  }

  bool isLeftChild() {
    if (parent is null) return false;
    return this is parent.children[0];
  }
  
  bool isRightChild() {
    if (parent is null) return false;
    return this is parent.children[1];
  }

  void insert(int n) {
    //writeln("insert ", n);
    if (n <= value) {
      if (children[0] is null) {
        children[0] = new RBTree(n, this);
        children[0].check_insert();
      } else { children[0].insert(n); }
    } else {
      if (children[1] is null) {
        children[1] = new RBTree(n, this);
        children[1].check_insert();
      } else { children[1].insert(n); }
    }
    //if (parent is null) display();
  }

  private void rotate_right() {
    //writeln("rotate_right");
    //display();
    RBTree A = children[0];
    RBTree l1 = A.children[0];
    RBTree l2 = A.children[1];
    RBTree l3 = children[1];
    int b = value;
    value = A.value;
    A.value = b;
    children[0] = l1;
    children[1] = A;
    A.children[0] = l2;
    A.children[1] = l3;
    if (l1 !is null) l1.parent = this;
    if (l2 !is null) l2.parent = A;
    if (l3 !is null) l3.parent = A;
    //display();
  }

  private void rotate_left() {
    //writeln("rotate_left");
    //display();
    RBTree A = children[1];
    RBTree l1 = A.children[1];
    RBTree l2 = A.children[0];
    RBTree l3 = children[0];
    int b = value;
    value = A.value;
    A.value = b;
    children[1] = l1;
    children[0] = A;
    A.children[1] = l2;
    A.children[0] = l3;
    if (l1 !is null) l1.parent = this;
    if (l2 !is null) l2.parent = A;
    if (l3 !is null) l3.parent = A;
    //display();
  }

  private void check_insert() {
    //writeln("check ", value);
    //writeln("case 1");
    if (parent is null) {
      black = true;
      return;
    }
    //writeln("case 2");
    if (parent.black) return;
    RBTree u = uncle;
    RBTree g = grandparent;
    //writeln("case 3");
    //writeln(parent.parent.children);
    if ((u !is null) && (!u.black)) {
      parent.black = true;
      u.black = true;
      g.black = false;
      return g.check_insert();
    }
    //writeln("case 4");
    if (isLeftChild() && parent.isRightChild()) {
      parent.rotate_right();
    }
    else if (isRightChild() && parent.isLeftChild()) {
      parent.rotate_left();
    }
    //writeln("case 5");
    g = grandparent;
    if (isLeftChild() && parent.isLeftChild()) {
      g.rotate_right();
    } else if (isRightChild() && parent.isRightChild()) {
      g.rotate_left();
    }
  }

  void remove(int n) {
    //if (parent is null) writeln("remove ", n);
    if (n == value) {
      if (children[0] !is null || children[1] !is null) {
        RBTree current;
        RBTree child;
        if (children[1] !is null) {
          current = children[1];
          while(current.children[0] !is null) {
            current = current.children[0];
          }
          child = current.children[1];
        } else {
          current = children[0];
          while (current.children[1] !is null) {
            current = current.children[1];
          }
          child = current.children[0];
        }
        if (current.isLeftChild()) {
         if (child is null) {
            current.check_remove();
            current.parent.children[0] = null;
          } else {
            current.parent.children[0] = child;
            child.parent = current.parent;
            if (current.black && !isBlack(child)) child.black = true;
            else child.check_remove();
          }
        } else {
          if (child is null) {
            current.check_remove();
            current.parent.children[1] = null;
          } else {
            current.parent.children[1] = child;
            child.parent = current.parent;
            if (current.black && !isBlack(child)) child.black = true;
            else child.check_remove();
          }
        }
        value = current.value;
      } else {
        if (isLeftChild()) {
          parent.children[0] = null;
          parent.check_remove();
        } else {
          parent.children[1] = null;
          parent.check_remove();
        }
      }
    }
    if (n < value && children[0] !is null) {
      children[0].remove(n);
    }
    if (n > value && children[1] !is null) {
      children[1].remove(n);
    }
    //if (parent is null) display();
  } 
  
  private void check_remove() {
    int side = 0;
    if (!black) return;
    //writeln("case 2");
    if (sibling.black == false) {
      if (isLeftChild()) {
        parent.rotate_left();
      } else {
        parent.rotate_right();
      }
    }
    //writeln("case 3");
    RBTree s = sibling;
    if (parent.black && s.black && 
      (s.children[0] is null || s.children[0].black) && 
      (s.children[1] is null || s.children[1].black)) {
      s.black = false;
      return parent.check_remove();
    }
    //writeln("case 4");
    if (parent.black == false && s.black &&  
      (s.children[0] is null || s.children[0].black) && 
      (s.children[1] is null || s.children[1].black)) {
      s.black = false;
      parent.black = true;
      return;
    }
    //writeln("case 5");
    if (s.black) {
      if (isLeftChild() &&
        (s.children[0] is null || s.children[0].black) &&
        (s.children[1] !is null && !s.children[1].black)) {
        s.rotate_right();
      }
      if (isRightChild() &&
        (s.children[1] is null || s.children[1].black) &&
        (s.children[0] !is null && !s.children[0].black)) {
        s.rotate_left();
      }
    }
    //writeln("case 6");
    if (isLeftChild()) {
      s.children[1].black = true;
      parent.rotate_left();
    }
    if (isRightChild()) {
      s.children[0].black = true;
      parent.rotate_right();
    }
  }

  static bool isBlack(RBTree tree) {
    if (tree is null) return true;
    return tree.black;
  }

  void display() {
    display("");
    writeln();
    assert(isTreeValid());
  }

  private void display(string indent) {
    if (children[0] !is null) {
      children[0].display(indent ~ "  ");
    }
    writeln(indent, value, black ? "B" : "R");
    if (children[1] !is null) {
      children[1].display(indent ~ "  ");
    }
  }
  
  void write() {
    if (children[0] !is null) {
      children[0].write();
    }
    writef(to!string(value) ~ " ");
    if (children[1] !is null) {
      children[1].write();
    }
  }

  bool canFind(int n) {
    if (value == n) return true;
    if (value > n && children[0] !is null) {
      return children[0].canFind(n);
    }
    if (value < n && children[1] !is null) {
      return children[1].canFind(n);
    }
    return false;
  }

  bool isTreeValid() {
    if ((!isLeftChild() && !isRightChild()) && parent !is null) return false;
    if (children[0] !is null && !children[0].isTreeValid()) return false;
    if (children[1] !is null && !children[1].isTreeValid()) return false;
    return true;
  }

  int opApply(int delegate(ref int) dg) {
    int result;
    if (children[0] !is null) {
      result = children[0].opApply(dg);
      if (result) return result;
    }
    result = dg(value);
    if (result) return result;
    if (children[1] !is null) {
      result = children[1].opApply(dg);
      if (result) return result;
    }
  }
}