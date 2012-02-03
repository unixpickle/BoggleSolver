//
//  BSSolverTest.h
//  BoggleSolver
//
//  Created by Alex Nichol on 2/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#include "BSSolver.h"

@interface BSSolverTest : SenTestCase {
    BSDictionaryRef dictionary;
    BSBoardRef board;
}

- (void)testSolve;

@end
