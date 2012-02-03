//
//  BSLoadingScreen.m
//  BoggleSolver
//
//  Created by Alex Nichol on 2/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BSLoadingScreen.h"

@implementation BSLoadingScreen

- (id)initWithWindow:(UIWindow *)aWindow {
    if ((self = [super initWithFrame:aWindow.bounds])) {
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.75];
        pane = [[BSLoadingPane alloc] initWithCenter:self.center status:@"Loading..."];
        [self addSubview:pane];
        [pane showByExpanding];
        [aWindow addSubview:self];
    }
    return self;
}

- (void)dismiss {
    [pane hideByShrinking:^ {
        [self removeFromSuperview];
    }];
}

@end
