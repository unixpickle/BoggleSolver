//
//  BSLoadingController.h
//  BoggleSolver
//
//  Created by Alex Nichol on 2/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BSLoadingScreen.h"

@interface BSLoadingController : NSObject {
    BSLoadingScreen * screen;
}

+ (BSLoadingController *)sharedLoadingController;
- (BOOL)isDisplayingScreen;
- (void)showLoadingScreen;
- (void)closeLoadingScreen;

@end
