#include <iostream>
using namespace std;

class OddGenerator {
    private:
      int x = -1;
    public:
      int nextOdd(){
        return x += 2;
      }
};

int main() {
    OddGenerator oddGen;
    cout << oddGen.nextOdd();
    cout << oddGen.nextOdd();
    cout << oddGen.nextOdd();
    return 0;
}