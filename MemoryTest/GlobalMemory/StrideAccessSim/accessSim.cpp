#include <iostream>

using namespace std;

int main(int argc, char* argv[])
{
    int blocks, line, stride, size;
    int currLoc;

    if (argc != 5)
    {
        cout << "./accessSim <Blocks> <Line size> <Stride> <Size>" << endl;
    }
    else
    {
        blocks = atoi(argv[1]);
        line = atoi(argv[2]);
        stride = atoi(argv[3]);
        size = atoi(argv[4]);
    }

    currLoc = 0;
    for (int i = 0 ; i < size ; i ++, currLoc += stride)
    {
        currLoc %= (blocks * line);
        for (int bIdx = 0; bIdx < (currLoc/line) ; bIdx ++)
        {
            for (int lIdx = 0; lIdx < line ; lIdx ++)
                cout << "_";
            cout << " ";
        }

        for (int lIdx = 0; lIdx < (currLoc%line); lIdx ++)
            cout << "_";
        cout << "o";
        for (int lIdx = (currLoc%line)+1; lIdx < line; lIdx ++)
            cout << "_";
        cout << " ";
        
        for (int bIdx = (currLoc/line) + 1; bIdx < blocks ; bIdx ++)
        {
            for (int lIdx = 0; lIdx < line ; lIdx ++)
                cout << "_";
            cout << " ";
        }
        cout << endl;
    }

}
