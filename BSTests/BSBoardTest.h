//
//  BSBoardTest.h
//  BoggleSolver
//
//  Created by Alex Nichol on 2/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#include "BSBoard.h"

struct BoardTestContext {
    uint8_t returnedPoints[8];
    int callbackCount;
};

@interface BSBoardTest : SenTestCase {
    BSBoardRef board;
}

- (void)testGetSet;
- (void)testAdjacent;

@end
