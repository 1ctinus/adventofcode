#include <fstream>
#include <string>
#include <sstream>
#include <cstdio>
int val = 1;
int cycles = 0;
void crtscan() {
  cycles++;
  if (cycles % 40 == val || cycles % 40 == val + 1 || cycles % 40 == val + 2) {
    putchar('@');
  } else {
    putchar('.');
  }
  if (cycles % 40 == 0) {
    putchar('\n');
  }
}
int main(int argc, char ** argv) {
  std::string line;
  std::ifstream infile(argv[1]);
  if (infile) {
    while (getline(infile, line)) {
      std::string substr = line.substr(4);
      std::stringstream stream(substr);
      int x = 0;
      stream >> x;
      crtscan();
      if (x != 0) {
        crtscan();
        val += x;
      }
    }
  }
  infile.close();
  return 0;
}
