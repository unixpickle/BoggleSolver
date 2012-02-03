//
//  BSBoard.c
//  BoggleSolver
//
//  Created by Alex Nichol on 2/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#include "BSBoard.h"

BSBoardRef bs_board_create(const char * pieces, uint8_t width, uint8_t height) {
    BSBoardRef board = (BSBoardRef)malloc(sizeof(struct _BSBoard));
    board->pieces = (char *)malloc(width * height);
    board->width = width;
    board->height = height;
    memcpy(board->pieces, pieces, width * height);
    return board;
}

BSBoardRef bs_board_duplicate(BSBoardRef board) {
    BSBoardRef newBoard = (BSBoardRef)malloc(sizeof(struct _BSBoard));
    newBoard->width = board->width;
    newBoard->height = board->height;
    newBoard->pieces = (char *)malloc(board->width * board->height);
    memcpy(newBoard->pieces, board->pieces, board->width * board->height);
    return newBoard;
}

void bs_board_free(BSBoardRef board) {
    free(board->pieces);
    free(board);
}

char bs_board_get(BSBoardRef board, uint8_t x, uint8_t y) {
    if (x >= board->width || y >= board->height) {
        return 0;
    }
    return board->pieces[x + (y * board->width)];
}

void bs_board_set(BSBoardRef board, uint8_t x, uint8_t y, char piece) {
    if (x >= board->width || y >= board->height) {
        abort();
    }
    board->pieces[x + (y * board->width)] = piece;
}

void bs_board_adjacent(BSBoardRef board, uint8_t x, uint8_t y, BSAdjacentCallback callback, void * userInfo) {
    for (int i = (int)x - 1; i < x + 2; i++) {
        if (i < 0 || i >= board->width) continue;
        for (int j = (int)y - 1; j < y + 2; j++) {
            if (j < 0 || j >= board->height) continue;
            if (j == y && i == x) continue;
            if (j != y && i != x) continue;
            // we will get this far only for sides and top/bottom
            callback(userInfo, (uint8_t)i, (uint8_t)j);
        }
    }
}
