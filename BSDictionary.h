//
//  BSDictionary.h
//  BoggleSolver
//
//  Created by Alex Nichol on 2/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#ifndef BoggleSolver_BSDictionary_h
#define BoggleSolver_BSDictionary_h

#include <stdio.h>
#include <string.h>
#include <stdlib.h>

typedef struct BSDictionaryWord {
    char letters[32];
} BSDictionaryWord;

struct _BSDictionary {
    BSDictionaryWord * words;
    int count;
};

typedef struct _BSDictionary * BSDictionaryRef;

BSDictionaryRef bs_dictionary_create(FILE * file);
void bs_dictionary_free(BSDictionaryRef dictionary);

int bs_dictionary_include(BSDictionaryRef dictionary, const char * word);
int bs_dictionary_include_prefix(BSDictionaryRef dictionary, const char * prefix);

#endif
