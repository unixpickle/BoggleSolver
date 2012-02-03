//
//  BSBoardObject.m
//  BoggleSolver
//
//  Created by Alex Nichol on 2/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BSBoardObject.h"

@implementation BSBoardObject

- (id)initWithBoardRef:(BSBoardRef)aBoard {
    if ((self = [super init])) {
        board = aBoard;
    }
    return self;
}

- (id)initWithPieces:(NSArray *)pieces width:(NSUInteger)width height:(NSUInteger)height {
    if ((self = [super init])) {
        char * boardStr = (char *)malloc([pieces count]);
        for (int i = 0; i < [pieces count]; i++) {
            boardStr[i] = (char)[[pieces objectAtIndex:i] characterAtIndex:0];
        }
        board = bs_board_create(boardStr, width, height);
        free(boardStr);
    }
    return self;
}

- (BSBoardRef)boardRef {
    return board;
}

- (id)copyWithZone:(NSZone *)zone {
    BSBoardRef boardCopy = bs_board_duplicate(board);
    return [[BSBoardObject allocWithZone:zone] initWithBoardRef:boardCopy];
}

#pragma mark - Information -

- (NSUInteger)width {
    return board->width;
}

- (NSUInteger)height {
    return board->height;
}

- (char)letterAtX:(NSUInteger)x y:(NSUInteger)y {
    return bs_board_get(board, x, y);
}

- (void)setLetter:(char)letter atX:(NSUInteger)x y:(NSUInteger)y {
    bs_board_set(board, x, y, letter);
}

#pragma mark - Solving -

- (NSArray *)solutionsForDictionary:(BSDictionaryObject *)dictionary {
    return [self solutionsForDictionary:dictionary allowDuplicates:NO minimumLength:3];
}

- (NSArray *)solutionsForDictionary:(BSDictionaryObject *)dictionary
                    allowDuplicates:(BOOL)flag 
                      minimumLength:(size_t)len {
    BSSolutionPoolRef pool = bs_board_solve(board, [dictionary dictionaryRef]);
    NSMutableArray * solutionArray = [NSMutableArray array];
    for (int i = 0; i < pool->count; i++) {
        BSSolutionRef solutionRef = pool->solutions[i];
        BSSolutionObject * solution = [[BSSolutionObject alloc] initWithSolutionRef:solutionRef];
        
        BOOL shouldAdd = YES;
        if ([[solution word] length] < len && len > 0) {
            shouldAdd = NO;
        }
        if (!flag && shouldAdd) {
            for (BSSolutionObject * existing in solutionArray) {
                if ([[existing word] isEqualToString:[solution word]]) {
                    shouldAdd = NO;
                    break;
                }
            }
        }
        if (shouldAdd) [solutionArray addObject:solution];
    }
    bs_solution_pool_free(pool, 0);
    return [NSArray arrayWithArray:solutionArray];
}

- (void)dealloc {
    bs_board_free(board);
}

@end
