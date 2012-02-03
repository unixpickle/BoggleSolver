//
//  BSBoardObject.h
//  BoggleSolver
//
//  Created by Alex Nichol on 2/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BSSolutionObject.h"
#import "BSDictionaryObject.h"
#include "BSBoard.h"

@interface BSBoardObject : NSObject {
    BSBoardRef board;
}

- (id)initWithBoardRef:(BSBoardRef)board;
- (id)initWithPieces:(NSArray *)pieces width:(NSUInteger)width height:(NSUInteger)height;
- (BSBoardRef)boardRef;

- (NSUInteger)width;
- (NSUInteger)height;
- (char)letterAtX:(NSUInteger)x y:(NSUInteger)y;
- (void)setLetter:(char)letter atX:(NSUInteger)x y:(NSUInteger)y;

- (NSArray *)solutionsForDictionary:(BSDictionaryObject *)dictionary;

@end
