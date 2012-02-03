//
//  BSDictionaryObject.h
//  BoggleSolver
//
//  Created by Alex Nichol on 2/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#include "BSDictionary.h"

@interface BSDictionaryObject : NSObject {
    BSDictionaryRef dictionary;
}

- (id)initWithFile:(NSString *)filePath;
- (BSDictionaryRef)dictionaryRef;

@end
