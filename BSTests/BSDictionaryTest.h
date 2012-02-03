//
//  BSDictionaryTest.h
//  BoggleSolver
//
//  Created by Alex Nichol on 2/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#include "BSDictionary.h"

@interface BSDictionaryTest : SenTestCase {
    BSDictionaryRef dictionary;
}

- (void)testInclude;
- (void)testPrefix;

@end
