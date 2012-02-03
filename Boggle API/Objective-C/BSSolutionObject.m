//
//  BSSolutionObject.m
//  BoggleSolver
//
//  Created by Alex Nichol on 2/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BSSolutionObject.h"

@implementation BSSolutionObject

- (id)initWithSolutionRef:(BSSolutionRef)aSolution {
    if ((self = [super init])) {
        solution = aSolution;
    }
    return self;
}

- (BSSolutionRef)solutionRef {
    return solution;
}

- (NSString *)word {
    return [NSString stringWithUTF8String:bs_solution_get_word(solution)];
}

- (BOOL)includesX:(uint8_t)x andY:(uint8_t)y {
    return bs_solution_include(solution, x, y);
}

- (void)dealloc {
    bs_solution_free(solution);
}

@end
