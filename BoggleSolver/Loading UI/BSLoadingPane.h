//
//  BSLoadingPane.h
//  BoggleSolver
//
//  Created by Alex Nichol on 2/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

#define kBSLoadingPaneSize 100

@interface BSLoadingPane : UIView {
    UILabel * statusLabel;
    UIActivityIndicatorView * activityIndicator;
}

- (id)initWithCenter:(CGPoint)center status:(NSString *)aStatus;
- (void)setStatus:(NSString *)status;
- (void)showByExpanding;
- (void)hideByShrinking:(void (^)())didHideBlock;

@end
