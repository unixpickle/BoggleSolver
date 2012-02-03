//
//  BSDictionaryObject.m
//  BoggleSolver
//
//  Created by Alex Nichol on 2/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BSDictionaryObject.h"

@implementation BSDictionaryObject

- (id)initWithFile:(NSString *)filePath {
    if ((self = [super init])) {
        FILE * fp = fopen([filePath UTF8String], "r");
        if (!fp) {
            return nil;
        }
        dictionary = bs_dictionary_create(fp);
        fclose(fp);
    }
    return self;
}

- (BSDictionaryRef)dictionaryRef {
    return dictionary;
}

- (void)dealloc {
    bs_dictionary_free(dictionary);
}

@end
