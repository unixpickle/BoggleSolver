//
//  BSDictionary.c
//  BoggleSolver
//
//  Created by Alex Nichol on 2/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#include "BSDictionary.h"

static int _WordComparator(const void * buff1, const void * buff2) {
    BSDictionaryWord * word1 = (BSDictionaryWord *)buff1;
    BSDictionaryWord * word2 = (BSDictionaryWord *)buff2;
    return strcmp(word1->letters, word2->letters);
}

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
    qsort(dictionary->words, dictionary->count, sizeof(BSDictionaryWord), _WordComparator);
    return dictionary;
}

void bs_dictionary_free(BSDictionaryRef dictionary) {
    free(dictionary->words);
    free(dictionary);
}

int bs_dictionary_include(BSDictionaryRef dictionary, const char * word) {
    int minIndex = 0, maxIndex = dictionary->count - 1;
    while (minIndex <= maxIndex) {
        int checkIndex = 0;
        checkIndex = (maxIndex - minIndex) / 2 + minIndex;
        
        int compResult = strcmp(dictionary->words[checkIndex].letters, word);
        if (compResult != 0 && minIndex == maxIndex) return 0;
        if (compResult < 0) {
            minIndex = checkIndex + 1;
        } else if (compResult > 0) {
            maxIndex = checkIndex - 1;
        } else {
            return 1;
        }
    }
    return 0;
}

int bs_dictionary_include_prefix(BSDictionaryRef dictionary, const char * prefix) {
    int minIndex = 0, maxIndex = dictionary->count - 1;
    while (minIndex <= maxIndex) {
        int checkIndex = 0;
        checkIndex = (maxIndex - minIndex) / 2 + minIndex;
        const char * compWord = dictionary->words[checkIndex].letters;
        if (strlen(compWord) >= strlen(prefix)) {
            if (memcmp(compWord, prefix, strlen(prefix)) == 0) {
                return 1;
            }
        }
        int compResult = strcmp(compWord, prefix);
        if (compResult != 0 && minIndex == maxIndex) return 0;
        if (compResult < 0) {
            minIndex = checkIndex + 1;
        } else if (compResult > 0) {
            maxIndex = checkIndex - 1;
        } else {
            return 1;
        }
        
    }
    return 0;
}
