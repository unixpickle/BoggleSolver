//
//  ViewController.h
//  BoggleSolver
//
//  Created by Alex Nichol on 2/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BSBoardView.h"

@interface ViewController : UIViewController <BSBoardViewDelegate, UITextFieldDelegate, UITableViewDataSource> {
    BSBoardView * boardView;
    
    UINavigationBar * titleBar;
    UINavigationItem * navItem;
    UIBarButtonItem * editButton, * doneButton;
    UIBarButtonItem * solveButton;
    
    UITextField * editingEntry;
    
    UITableView * solutionTable;
    NSArray * solutions;
}

- (void)editButton:(id)sender;
- (void)doneButton:(id)sender;
- (void)solveButton:(id)sender;

- (void)beginEditUI;
- (void)endEditUI;
- (void)keyboardWillShow:(NSNotification *)notification;
- (void)keyboardWillHide:(NSNotification *)notification;

@end
