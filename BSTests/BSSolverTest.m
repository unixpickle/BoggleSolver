//
//  BSSolverTest.m
//  BoggleSolver
//
//  Created by Alex Nichol on 2/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BSSolverTest.h"

@implementation BSSolverTest

- (void)setUp {
    [super setUp];
    NSString * dictionaryPath = @"/Users/Shared/md5crack1_dictionary.txt";
    FILE * fp = fopen([dictionaryPath UTF8String], "r");
    board = bs_board_create("thisisetetseabcd", 4, 4);
    dictionary = bs_dictionary_create(fp);
    fclose(fp);
}

- (void)tearDown {
    [super tearDown];
    bs_board_free(board);
    bs_dictionary_free(dictionary);
}

- (void)testSolve {
    BSSolutionPoolRef pool = bs_board_solve(board, dictionary);
    for (int i = 0; i < pool->count; i++) {
        NSLog(@"Solution: %s", bs_solution_get_word(pool->solutions[i]));
    }
    bs_solution_pool_free(pool, 1);
}

@end
