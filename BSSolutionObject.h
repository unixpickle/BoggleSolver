//
//  BSSolutionObject.h
//  BoggleSolver
//
//  Created by Alex Nichol on 2/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#include "BSSolver.h"

@interface BSSolutionObject : NSObject {
    BSSolutionRef solution;
}

- (id)initWithSolutionRef:(BSSolutionRef)solution;
- (BSSolutionRef)solutionRef;
- (NSString *)word;
- (BOOL)includesX:(uint8_t)x andY:(uint8_t)y;

@end
