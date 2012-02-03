//
//  BSDictionaryTest.m
//  BoggleSolver
//
//  Created by Alex Nichol on 2/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BSDictionaryTest.h"

@implementation BSDictionaryTest

- (void)setUp {
    [super setUp];
    NSString * path = [[NSBundle mainBundle] pathForResource:@"dictionary" ofType:@"txt"];
    if (!path) {
        path = @"/Users/Shared/md5crack1_dictionary.txt";
    }
    STAssertNotNil(path, @"Cannot locate test dictionary");
    FILE * fp = fopen([path UTF8String], "r");
    STAssertTrue(fp != NULL, @"Failed to open: %@", path);
    dictionary = bs_dictionary_create(fp);
    fclose(fp);
}

- (void)tearDown {
    [super tearDown];
    bs_dictionary_free(dictionary);
}

- (void)testInclude {
    STAssertTrue(bs_dictionary_include(dictionary, "apple"), @"False negative");
    STAssertTrue(bs_dictionary_include(dictionary, "lousy"), @"False negative");
    STAssertTrue(bs_dictionary_include(dictionary, "orange"), @"False negative");
    STAssertTrue(!bs_dictionary_include(dictionary, "\x02\x03"), @"False positive");
}

- (void)testPrefix {
    STAssertTrue(bs_dictionary_include_prefix(dictionary, "l"), @"False negative");
    STAssertTrue(bs_dictionary_include_prefix(dictionary, "app"), @"False negative");
    STAssertTrue(bs_dictionary_include_prefix(dictionary, "lou"), @"False negative");
    STAssertTrue(bs_dictionary_include_prefix(dictionary, "orange"), @"False negative");
    STAssertTrue(!bs_dictionary_include_prefix(dictionary, "thisaintaword"), @"False positive");
}

@end
