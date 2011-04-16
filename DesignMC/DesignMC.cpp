//
//  DesignMC.cpp
//  DesignMC
//
//  Created by Andy Drizen on 16/04/2011.
//  Copyright 2011 Andy Drizen. All rights reserved.
//

#include "DesignMC.hpp"

Square::Square( int n )
{
    for(int i=0; i < n; i++)
    {
        
        for(int j=0; j < n; j++)
        {
            block tmp_block (3);
            int tmp_blockArr[] = {i,n + j,2*n + (i+j) % n};
            tmp_block.assign(tmp_blockArr, tmp_blockArr+3);
            blocks.push_back(tmp_block);
        }
    }
    this->v = 3*n;
    this->t = 2;
    this->improper = false;
    this->blockNumbers = n*n;
    
    int k[] = {1,1,1};
    this->k.assign(k, k+3);
    
    int vType[] = {n,n,n};
    this->vType.assign(vType, vType+3);
}

block Square::generatePivot()
{
    if (this->improper)
    {
        return this->negatives[ rand() % negatives.size() ];
    }
    
    //To gain aperiodic status, we allow the chain to add a block that exists.
    
    //bool IsAlreadyABlock = true;
    block pivot;
    //while(IsAlreadyABlock)
    //{
    int pivotArr[] = {rand() % vType[0], this->vType[1] + rand() % vType[1],2*this->vType[2] + rand() % vType[2]};
    pivot.assign(pivotArr, pivotArr+3);
    
    blockSet::iterator myIt = find (blocks.begin(), blocks.end(), pivot);
    //if( myIt == blocks.end())
    //IsAlreadyABlock = false;
    //}
    
    return pivot;
}
void Square::hopper()
{
    block pivot = this->generatePivot();
    
    block possibilitiesZ;
    block possibilitiesY;
    block possibilitiesX;
    
    for (unsigned int i = 0; i < this->blocks.size(); i++)
    {
        if (pivot[0] == blocks[i][0] && pivot[1] == blocks[i][1])
            possibilitiesZ.push_back(blocks[i][2]);
        if (pivot[0] == blocks[i][0] && pivot[2] == blocks[i][2])
            possibilitiesY.push_back(blocks[i][1]);
        if (pivot[1] == blocks[i][1] && pivot[2] == blocks[i][2])
            possibilitiesX.push_back(blocks[i][0]);
    }
    
    int x = possibilitiesX[ rand() % possibilitiesX.size()];
    int y = possibilitiesY[ rand() % possibilitiesY.size()];
    int z = possibilitiesZ[ rand() % possibilitiesZ.size()];
    
    int blockToRemoveArr[] = {x,y,z};
    block blockToRemove;
    blockToRemove.assign(blockToRemoveArr, blockToRemoveArr+3);
    
    // Exchange blocks
    
    blockSet::iterator myIt1 = find(this->negatives.begin(), this->negatives.end(), pivot);
    if ( myIt1 == negatives.end() )
        this->blocks.push_back(pivot);
    else
        this->negatives.erase(myIt1);
    
    blockSet::iterator myIt2 = find(this->blocks.begin(), this->blocks.end(), blockToRemove);
    if( myIt2 == blocks.end() )
    {
        this->improper = true;
        this->negatives.push_back(blockToRemove);
    }
    else
    {
        this->improper = false;
        this->blocks.erase(myIt2);
    }
    
    int a1Arr[] = {pivot[0], y, z};
    block a1;
    a1.assign(a1Arr, a1Arr+3);
    this->blocks.push_back(a1);
    
    int a2Arr[] = {x, pivot[1], z};
    block a2;
    a2.assign(a2Arr, a2Arr+3);
    this->blocks.push_back(a2);
    
    int a3Arr[] = {x, y, pivot[2]};
    block a3;
    a3.assign(a3Arr, a3Arr+3);
    this->blocks.push_back(a3);
    
    int r1Arr[] = {pivot[0], pivot[1], z};
    block r1;
    r1.assign(r1Arr, r1Arr+3);
    blockSet::iterator myIt3 = find(this->blocks.begin(), this->blocks.end(), r1);
    this->blocks.erase(myIt3);
    
    int r2Arr[] = {pivot[0], y, pivot[2]};
    block r2;
    r2.assign(r2Arr, r2Arr+3);
    blockSet::iterator myIt4 = find(this->blocks.begin(), this->blocks.end(), r2);
    this->blocks.erase(myIt4);
    
    int r3Arr[] = {x, pivot[1], pivot[2]};
    block r3;
    r3.assign(r3Arr, r3Arr+3);
    blockSet::iterator myIt5 = find(this->blocks.begin(), this->blocks.end(), r3);
    this->blocks.erase(myIt5);
    
    sort(this->blocks.begin(), this->blocks.end());
    this->blockNumbers = blocks.size();
}
void Square::oneStep()
{
    do
    {
        this->hopper();
    }
    while (this->improper);
}
void Square::manyStepsProper( int j )
{
    for(int i=0; i<j; i++)
    {
        this->oneStep();
    }
}
void Square::manyStepsImproper( int j )
{
    for(int i=0; i<j; i++)
    {
        this->hopper();
    }
    while(this->improper == false)
    {
        this->hopper();
    }
}    
bool Square::isMainDiagonalTransversal()
{
    block pointsOnDiagonal;
    for(int i=0; i < this->vType[0]; i++)
    {
        for(int k=vType[0]+vType[1]; k < vType[0]+vType[1]+vType[2]; k++)
        {
            int potentialBlock[] = {i,i+vType[0],k};
            block diagonalPerhaps;
            diagonalPerhaps.assign(potentialBlock, potentialBlock+3);
            blockSet::iterator myIt = find(this->blocks.begin(), this->blocks.end(), diagonalPerhaps);
            if( myIt != blocks.end() )
            {
                pointsOnDiagonal.push_back(k);
                break;
            }
        }
    }
    sort(pointsOnDiagonal.begin(), pointsOnDiagonal.end());
    
    for (int i = vType[0]+vType[1]; i < vType[0]+vType[1]+vType[2]; i++)
    {
        if (i!=pointsOnDiagonal[i-vType[0]-vType[1]])
            return false;
    }
    
    return true;
}

// Setters
void Square::setPath( const char* path )
{
    this->path = path;
}

// Getters

blockSet Square::getBlocks()
{
    return this->blocks;
}
int Square::getVType()
{
    return this->vType[0];
}


string Square::stringifyBlocks( blockSet bs )
{
    
    string str = "[";
    for(unsigned int i=0; i < bs.size(); i++)
    {
        
        stringstream out;
        out << "[" << bs[i][0]+1 << ", " << bs[i][1]+1 << ", "<< bs[i][2]+1 << "]";
        str += out.str();
        
        if( i < bs.size() - 1)
            str += ", ";
    }
    str += "]";
    return str;
}