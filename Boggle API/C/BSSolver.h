//
//  BSSolver.h
//  BoggleSolver
//
//  Created by Alex Nichol on 2/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#ifndef BoggleSolver_BSSolver_h
#define BoggleSolver_BSSolver_h

#include "BSBoard.h"
#include "BSDictionary.h"

typedef struct {
    uint8_t x, y;
    char letter;
} BSSolutionTerm;

struct _BSSolution {
    BSSolutionTerm * terms;
    int count, size;
};
typedef struct _BSSolution * BSSolutionRef;

struct _BSSolutionPool {
    BSSolutionRef * solutions;
    int count, size;
};
typedef struct _BSSolutionPool * BSSolutionPoolRef;

typedef struct {
    BSBoardRef board;
    BSDictionaryRef dictionary;
    BSSolutionPoolRef pool;
    BSSolutionRef solution;
} BSSolverContext;

BSSolutionTerm BSSolutionTermCreate(uint8_t x, uint8_t y, char letter);

BSSolutionRef bs_solution_create(void);
void bs_solution_free(BSSolutionRef solution);
void bs_solution_append(BSSolutionRef solution, BSSolutionTerm term);
const char * bs_solution_get_word(BSSolutionRef solution);
int bs_solution_include(BSSolutionRef solution, uint8_t x, uint8_t y);
BSSolutionRef bs_solution_duplicate(BSSolutionRef solution);

BSSolutionPoolRef bs_solution_pool_create(void);
void bs_solution_pool_free(BSSolutionPoolRef pool, int freeContents);
void bs_solution_pool_append(BSSolutionPoolRef pool, BSSolutionRef solution);

BSSolutionPoolRef bs_board_solve(BSBoardRef board, BSDictionaryRef dictionary);

#endif
