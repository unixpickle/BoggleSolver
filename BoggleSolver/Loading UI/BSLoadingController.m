//
//  BSLoadingController.m
//  BoggleSolver
//
//  Created by Alex Nichol on 2/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BSLoadingController.h"

@implementation BSLoadingController

+ (BSLoadingController *)sharedLoadingController {
    static BSLoadingController * sharedInstance = nil;
    if (!sharedInstance) {
        sharedInstance = [[BSLoadingController alloc] init];

    }
//    dispatch_once_t dispatch;
//    dispatch_once(&dispatch, ^ {
//    });
    return sharedInstance;
}

- (BOOL)isDisplayingScreen {
    if (screen) return YES;
    return NO;
}

- (void)showLoadingScreen {
    if ([self isDisplayingScreen]) return;
    UIWindow * window = [[[UIApplication sharedApplication] windows] objectAtIndex:0];
    screen = [[BSLoadingScreen alloc] initWithWindow:window];
}

- (void)closeLoadingScreen {
    [screen dismiss];
    screen = nil;
}

@end
