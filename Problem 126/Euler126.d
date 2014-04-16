import std.stdio;
import std.conv;

struct Layer {
  int cubes;
  ushort sum;
  ushort x;
  ushort y;
  ushort n;
  ushort z() { return cast(ushort)(sum - x - y); }
}

void main() {
  Layer[][] data;
  int total = 0;
  int cubes = 4;
  while (total != 1000) {
    if (total % 100 == 0) writeln(cubes, ": ", total);
    //writeln(cubes, ": ", total);
    cubes += 2;
    //writeln(cubes);
    total = 0;
    if ((cubes - 2) % 4 == 0) {
      ushort sum = cast(ushort)((cubes + 6) / 4);
      //writeln("sum: ", sum);
      Layer[] tempLayers = [];
      foreach (z; 1..sum / 3 + 1) {
        foreach (y; z..(sum - z) / 2 + 1) {
          ushort x = cast(ushort)(sum - y - z);
          int tempCubes = 2 * (x * y + y * z + z * x);
          tempLayers ~= Layer(tempCubes, sum, x, cast(ushort)y, 1);
        }
      }
      data ~= tempLayers;
    }
    //writeln(data);
    foreach (sum, layers; data) {
      foreach (i, layer; layers) {
        if (cubes != layer.cubes) continue;
        total++;
        layer.cubes += (sum + 3) * 4;
        layer.cubes += 8 * (layer.n - 1);
        layer.n++;
        layers[i] = layer;
      }
    }
    //writeln("total: ", total);
    //writeln(data);
    //readln();
  }
}