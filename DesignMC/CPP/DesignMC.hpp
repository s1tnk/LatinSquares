//
//  DesignMC.h
//  DesignMC
//
//  Created by Andy Drizen on 16/04/2011.
//  Copyright 2011 Andy Drizen. All rights reserved.
//

#include <iostream>
#include <vector>
#include <stdlib.h>
#include <time.h>
#include <algorithm>
#include <string>
#include <sstream>
#include <fstream>
#include <cmath>
using namespace std;
typedef vector< int > block;
typedef vector< block > blockSet;

class Square
{
private:
    blockSet blocks;
    blockSet negatives;
    int v;
    int t;
    bool improper;
    int blockNumbers;
    block k;
    block vType;
    const char* path;
public:
    Square(int n);
    block generatePivot();
    void hopper();
    void oneStep();
    void manyStepsProper( int j );
    int getVType();
    blockSet getBlocks();
    void manyStepsImproper( int j );
    bool isMainDiagonalTransversal();
    void setPath( const char* path );
    string stringifyBlocks( blockSet bs );
    ~Square();
};