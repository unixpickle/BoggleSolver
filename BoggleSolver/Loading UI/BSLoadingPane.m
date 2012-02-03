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
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.95];
        self.layer.cornerRadius = 10;
        
        statusLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 15, kBSLoadingPaneSize - 20, 20)];
        [statusLabel setBackgroundColor:[UIColor clearColor]];
        [statusLabel setTextColor:[UIColor whiteColor]];
        [statusLabel setTextAlignment:UITextAlignmentCenter];
        [statusLabel setText:aStatus];
        
        activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        [activityIndicator setCenter:CGPointMake(kBSLoadingPaneSize / 2, kBSLoadingPaneSize / 2 + 10)];
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
    self.layer.transform = CATransform3DMakeScale(1, 0.1, 1);
    self.alpha = 0;
    [UIView animateWithDuration:0.3 animations:^ {
        self.layer.transform = CATransform3DIdentity;
        self.alpha = 1;
    }];
}

- (void)hideByShrinking:(void (^)())didHideBlock {
    [UIView animateWithDuration:0.3 animations:^ {
        self.layer.transform = CATransform3DMakeScale(1, 0.1, 1);
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        self.layer.transform = CATransform3DIdentity;
        if (didHideBlock) didHideBlock();
    }];
}

@end
