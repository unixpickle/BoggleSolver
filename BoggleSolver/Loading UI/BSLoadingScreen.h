//
//  BSLoadingScreen.h
//  BoggleSolver
//
//  Created by Alex Nichol on 2/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BSLoadingPane.h"

@interface BSLoadingScreen : UIView {
    BSLoadingPane * pane;
    UIWindow * window;
}

- (id)initWithWindow:(UIWindow *)aWindow;
- (void)dismiss;

@end
