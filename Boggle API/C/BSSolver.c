//
//  BSSolver.c
//  BoggleSolver
//
//  Created by Alex Nichol on 2/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#include "BSSolver.h"

BSSolutionTerm BSSolutionTermCreate(uint8_t x, uint8_t y, char letter) {
    BSSolutionTerm term;
    term.x = x;
    term.y = y;
    term.letter = letter;
    return term;
}

#pragma mark - Solution -

BSSolutionRef bs_solution_create(void) {
    BSSolutionRef solution = (BSSolutionRef)malloc(sizeof(struct _BSSolution));
    solution->count = 0;
    solution->size = 16;
    solution->terms = (BSSolutionTerm *)malloc(sizeof(BSSolutionTerm) * 16);
    return solution;
}

void bs_solution_free(BSSolutionRef solution) {
    free(solution->terms);
    free(solution);
}

void bs_solution_append(BSSolutionRef solution, BSSolutionTerm term) {
    if (solution->count == solution->size) {
        solution->size += 16;
        solution->terms = (BSSolutionTerm *)realloc(solution->terms, sizeof(BSSolutionTerm) * solution->size);
    }
    solution->terms[solution->count] = term;
    solution->count++;
}

const char * bs_solution_get_word(BSSolutionRef solution) {
    static char buffer[32];
    for (int i = 0; i < solution->count && i < 31; i++) {
        buffer[i] = solution->terms[i].letter;
        buffer[i + 1] = 0;
    }
    return buffer;
}

int bs_solution_include(BSSolutionRef solution, uint8_t x, uint8_t y) {
    for (int i = 0; i < solution->count; i++) {
        if (solution->terms[i].x == x && solution->terms[i].y == y) {
            return 1;
        }
    }
    return 0;
}

BSSolutionRef bs_solution_duplicate(BSSolutionRef solution) {
    BSSolutionRef duplicate = (BSSolutionRef)malloc(sizeof(struct _BSSolution));
    duplicate->count = solution->count;
    duplicate->size = solution->size;
    duplicate->terms = (BSSolutionTerm *)malloc(sizeof(BSSolutionTerm) * solution->size);
    memcpy(duplicate->terms, solution->terms, sizeof(BSSolutionTerm) * solution->count);
    return duplicate;
}

#pragma mark - Solution Pool -

BSSolutionPoolRef bs_solution_pool_create(void) {
    BSSolutionPoolRef pool = (BSSolutionPoolRef)malloc(sizeof(struct _BSSolutionPool));
    pool->count = 0;
    pool->size = 16;
    pool->solutions = (BSSolutionRef *)malloc(sizeof(BSSolutionRef) * 16);
    return pool;
}

void bs_solution_pool_free(BSSolutionPoolRef pool, int freeContents) {
    if (freeContents) {
        for (int i = 0; i < pool->count; i++) {
            bs_solution_free(pool->solutions[i]);
        }
    }
    free(pool->solutions);
    free(pool);
}

void bs_solution_pool_append(BSSolutionPoolRef pool, BSSolutionRef solution) {
    if (pool->count == pool->size) {
        pool->size += 16;
        pool->solutions = (BSSolutionRef *)realloc(pool->solutions, sizeof(BSSolutionRef) * pool->size);
    }
    pool->solutions[pool->count] = solution;
    pool->count++;
}

#pragma mark - Solving -

static void _bs_board_solve_callback(void * userInfo, uint8_t x, uint8_t y) {
    BSSolverContext * context = (BSSolverContext *)userInfo;
    if (bs_solution_include(context->solution, x, y)) return;
    // decode using context
    char letter = bs_board_get(context->board, x, y);
    BSSolutionRef solution = bs_solution_duplicate(context->solution);
    bs_solution_append(solution, BSSolutionTermCreate(x, y, letter));
    const char * word = bs_solution_get_word(solution);
    int isFullWord = bs_dictionary_include(context->dictionary, word);
    if (bs_dictionary_include_prefix(context->dictionary, word)) {
        BSSolverContext subContext;
        subContext.solution = solution;
        subContext.pool = context->pool;
        subContext.dictionary = context->dictionary;
        subContext.board = context->board;
        bs_board_adjacent(context->board, x, y, _bs_board_solve_callback, &subContext);
    }
    if (isFullWord) {
        bs_solution_pool_append(context->pool, solution);
    } else {
        bs_solution_free(solution);
    }
}

BSSolutionPoolRef bs_board_solve(BSBoardRef board, BSDictionaryRef dictionary) {
    BSSolverContext context;
    context.pool = bs_solution_pool_create();
    context.dictionary = dictionary;
    context.board = board;
    for (uint8_t y = 0; y < board->height; y++) {
        for (uint8_t x = 0; x < board->width; x++) {
            context.solution = bs_solution_create();
            _bs_board_solve_callback(&context, x, y);
            bs_solution_free(context.solution);
        }
    }
    return context.pool;
}
