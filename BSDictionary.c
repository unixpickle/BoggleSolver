//
//  BSDictionary.c
//  BoggleSolver
//
//  Created by Alex Nichol on 2/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#include "BSDictionary.h"

static void chomp(char * str) {
    if (strlen(str) == 0) return;
    if (str[strlen(str) - 1] == '\n') {
        str[strlen(str) - 1] = 0;
    }
    if (strlen(str) == 0) return;
    if (str[strlen(str) - 1] == '\r') {
        str[strlen(str) - 1] = 0;
    }
}

BSDictionaryRef bs_dictionary_create(FILE * file) {
    char buffer[32];
    int numAlloc = 32;
    BSDictionaryRef dictionary = (BSDictionaryRef)malloc(sizeof(struct _BSDictionary));
    dictionary->count = 0;
    dictionary->words = (BSDictionaryWord *)malloc(sizeof(BSDictionaryWord) * numAlloc);
    while (fgets(buffer, 32, file)) {
        chomp(buffer);
        if (dictionary->count == numAlloc) {
            numAlloc += 32;
            dictionary->words = (BSDictionaryWord *)realloc(dictionary->words, sizeof(BSDictionaryWord) * numAlloc);
        }
        memcpy(dictionary->words[dictionary->count].letters, buffer, 32);
        dictionary->count++;
    }
    return dictionary;
}

void bs_dictionary_free(BSDictionaryRef dictionary) {
    free(dictionary->words);
    free(dictionary);
}

int bs_dictionary_include(BSDictionaryRef dictionary, const char * word) {
    for (int i = 0; i < dictionary->count; i++) {
        char * buff = dictionary->words[i].letters;
        if (strcmp(buff, word) == 0) return 1;
    }
    return 0;
}

int bs_dictionary_include_prefix(BSDictionaryRef dictionary, const char * prefix) {
    size_t preflen = strlen(prefix);
    for (int i = 0; i < dictionary->count; i++) {
        char * buff = dictionary->words[i].letters;
        if (strlen(buff) >= preflen) {
            if (memcmp(buff, prefix, preflen) == 0) return 1;
        }
    }
    return 0;
}
