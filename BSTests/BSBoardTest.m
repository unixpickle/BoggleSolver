//
//  BSBoardTest.m
//  BoggleSolver
//
//  Created by Alex Nichol on 2/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BSBoardTest.h"

static void BoardCallback(void * userInfo, uint8_t x, uint8_t y) {
    struct BoardTestContext * context = (struct BoardTestContext *)userInfo;
    context->returnedPoints[context->callbackCount * 2] = x;
    context->returnedPoints[context->callbackCount * 2 + 1] = y;
    context->callbackCount += 1;
}

@implementation BSBoardTest

- (void)setUp {
    [super setUp];
    board = bs_board_create("abcdefghijklmnop", 4, 4);
}

- (void)tearDown {
    [super tearDown];
    bs_board_free(board);
}

- (void)testGetSet {
    STAssertTrue(bs_board_get(board, 3, 3) == 'p', @"Invalid piece returned.");
    STAssertTrue(bs_board_get(board, 0, 0) == 'a', @"Invalid piece returned.");
    bs_board_set(board, 2, 1, 'j');
    STAssertTrue(bs_board_get(board, 2, 1) == 'j', @"Invalid piece returned after set.");
}

- (void)testAdjacent {
    struct BoardTestContext context;
    bzero(&context, sizeof(context));
    bs_board_adjacent(board, 1, 1, BoardCallback, &context);
    
    STAssertTrue(context.callbackCount == 4, @"Invalid number of callbacks.");
    int goodCount = 0;
    for (int i = 0; i < 4; i++) {
        if (context.returnedPoints[i * 2] == 0 && context.returnedPoints[i * 2 + 1] == 1) {
            goodCount++;
        } else if (context.returnedPoints[i * 2] == 2 && context.returnedPoints[i * 2 + 1] == 1) {
            goodCount++;
        } else if (context.returnedPoints[i * 2] == 1 && context.returnedPoints[i * 2 + 1] == 0) {
            goodCount++;
        } else if (context.returnedPoints[i * 2] == 1 && context.returnedPoints[i * 2 + 1] == 2) {
            goodCount++;
        }
    }
    STAssertTrue(goodCount == 4, @"Callback info incorrect.");
}

@end
