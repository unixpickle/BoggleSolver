//
//  ViewController.h
//  BoggleSolver
//
//  Created by Alex Nichol on 2/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BSBoardView.h"

@interface ViewController : UIViewController <BSBoardViewDelegate, UITextFieldDelegate> {
    BSBoardView * boardView;
    
    UINavigationBar * titleBar;
    UINavigationItem * navItem;
    UIBarButtonItem * editButton, * doneButton;
    UIBarButtonItem * solveButton;
    
    UITextField * editingEntry;
}

- (void)editButton:(id)sender;
- (void)doneButton:(id)sender;
- (void)solveButton:(id)sender;

- (void)beginEditUI;
- (void)endEditUI;

@end
