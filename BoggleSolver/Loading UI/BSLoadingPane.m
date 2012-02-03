//
//  BSLoadingPane.m
//  BoggleSolver
//
//  Created by Alex Nichol on 2/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BSLoadingPane.h"

@implementation BSLoadingPane

- (id)initWithCenter:(CGPoint)center status:(NSString *)aStatus {
    if ((self = [super initWithFrame:CGRectMake(center.x - (kBSLoadingPaneSize / 2),
                                                center.y - (kBSLoadingPaneSize / 2),
                                                kBSLoadingPaneSize, kBSLoadingPaneSize)])) {
        statusLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 20, kBSLoadingPaneSize - 20, 20)];
        [statusLabel setBackgroundColor:[UIColor clearColor]];
        [statusLabel setTextColor:[UIColor whiteColor]];
        [statusLabel setText:aStatus];
        activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        [activityIndicator setCenter:CGPointMake(kBSLoadingPaneSize / 2, kBSLoadingPaneSize / 2)];
        [activityIndicator startAnimating];
        [self addSubview:statusLabel];
        [self addSubview:activityIndicator];
    }
    return self;
}

- (void)setStatus:(NSString *)status {
    [statusLabel setText:status];
}
    
- (void)showByExpanding {
    self.layer
}

- (void)hideByShrinking {
    
}

@end
