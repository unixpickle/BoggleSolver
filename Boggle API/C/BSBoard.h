//
//  BSBoard.h
//  BoggleSolver
//
//  Created by Alex Nichol on 2/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#ifndef BoggleSolver_BSBoard_h
#define BoggleSolver_BSBoard_h

#include <stdlib.h>
#include <stdint.h>
#include <string.h>

struct _BSBoard {
    char * pieces;
    uint8_t width, height;
};

typedef struct _BSBoard * BSBoardRef;

typedef void (*BSAdjacentCallback)(void * userInfo, uint8_t x, uint8_t y);

BSBoardRef bs_board_create(const char * pieces, uint8_t width, uint8_t height);
BSBoardRef bs_board_duplicate(BSBoardRef board);
void bs_board_free(BSBoardRef board);

char bs_board_get(BSBoardRef board, uint8_t x, uint8_t y);
void bs_board_set(BSBoardRef board, uint8_t x, uint8_t y, char piece);

void bs_board_adjacent(BSBoardRef board, uint8_t x, uint8_t y, BSAdjacentCallback callback, void * userInfo);

#endif
