#include <iostream>
#include <cmath>
#include <climits>

using namespace std;

typedef struct Cache_Data
{
    bool empty;
    unsigned long long timeStamp;
    long long tag;

    Cache_Data() : empty(true), timeStamp(0), tag(0) {}
} Cache_Data;

class Cache_Template
{
private:
    int associativity;
    int indexBit;
    int blockBit;
    bool isLog;
    int hitCount;
    int missCount;
    unsigned long long currTime;

    Cache_Data** content;

public:
    Cache_Template(int, int, int);
    ~Cache_Template();

    bool Access(long long);
    void StartLog() {isLog = true;}
    void ShowStatistics();
};


int main(int argc, char *argv[])
{
    if (argc != 7)
    {
        cout << "./accessSim <Way> <Index bits> <Block bits> <Stride> <Size> <Iteration>" << endl;
        exit(1);
    }
    else
    {
        long iteration;
        long long currentAddress;
        int way, iBit, bBit, stride, size;

        way = atoi(argv[1]);
        iBit = atoi(argv[2]);
        bBit = atoi(argv[3]);
        Cache_Template cache(way, iBit, bBit);
        stride = atoi(argv[4]);
        size = atoi(argv[5]);
        iteration = atol(argv[6]);
        currentAddress = 0;

        // calculate address
        for (int i = 0 ; i < size ; i ++)
        {
            cache.Access(currentAddress);
            currentAddress += stride * 8;
        }

        currentAddress = 0;
        cache.StartLog();
        for (long i = 0 ; i < iteration ; i ++)
        {
            cache.Access(currentAddress);
            currentAddress += stride * 8;
            if ((i % size) == (size - 1))
                currentAddress = 0;
        }
        cache.ShowStatistics();
    }
}


Cache_Template::Cache_Template(int ass, int iBit, int bBit) : isLog(false), hitCount(0), missCount(0), associativity(ass), indexBit(iBit), blockBit(bBit), currTime(0)
{
    content = new Cache_Data*[associativity];
    for (int i = 0 ; i < associativity ; i ++)
    {
        content[i] = new Cache_Data[1 << indexBit];
    }
}

Cache_Template::~Cache_Template()
{
    for (int i = 0 ; i < associativity ; i ++)
    {
        delete [] content[i];
    }
    delete [] content;
}

// return TRUE for hit, FALSE for miss
bool Cache_Template::Access(long long address)
{
    int idx = (address >> blockBit) & ((1 << indexBit) - 1);
    long long tag = address >> (blockBit + indexBit);
    int targetWay;
    unsigned long long  minTimeStamp = ULLONG_MAX;
    int minWay = -1;

    for (targetWay = 0 ; targetWay < associativity ; targetWay ++)
    {
        if ((!content[targetWay][idx].empty) && (content[targetWay][idx].tag == tag))
            break;
    }
    
    // hit
    if (targetWay != associativity)
    {
        content[targetWay][idx].timeStamp = (currTime++);
        
        if (isLog)  hitCount++;
        return true;
    }

    // miss
    for (targetWay = 0 ; targetWay < associativity ; targetWay ++)
    {
        if (content[targetWay][idx].empty)
        {
            content[targetWay][idx].empty = false;
            content[targetWay][idx].tag = tag;
            content[targetWay][idx].timeStamp = (currTime++);

            if (isLog)  missCount++;
            return false;
        }
        else    // find victim
        {
            if (content[targetWay][idx].timeStamp < minTimeStamp)
            {
                minTimeStamp = content[targetWay][idx].timeStamp;
                minWay = targetWay;
            }
        }
    }

    // TODO: write back?
    content[minWay][idx].tag = tag;
    content[minWay][idx].timeStamp = (currTime++);
    if (isLog)  missCount++;
    return false;
}

void Cache_Template::ShowStatistics()
{
    cout << "==========================================" << endl;
    cout << "\tTotal access: " << missCount + hitCount << endl;
    cout << "\t\thit:  " << hitCount << endl;
    cout << "\t\tmiss: " << missCount << endl;
    cout << "\t\tmiss rate: " << (missCount / double(missCount + hitCount)) * 100 << " %" << endl;
}
