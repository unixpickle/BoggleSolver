//
//  ViewController.m
//  BoggleSolver
//
//  Created by Alex Nichol on 2/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"

@interface ViewController (UIConfiguration)

- (void)setupTitleBar;

@end

@implementation ViewController

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View Configuration -

- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    // NSString * filePath = [[NSBundle mainBundle] pathForResource:@"dictionary" ofType:@"txt"];
    // BSDictionaryObject * dictionary = [[BSDictionaryObject alloc] initWithFile:filePath];
    
    [self setupTitleBar];
    
    NSArray * pieces = [NSArray arrayWithObjects:@"e", @"x", @"a", @"m",
                                                 @"h", @"e", @"l", @"p",
                                                 @"e", @"a", @"d", @"s",
                                                 @"e", @"r", @"e", @"h", nil];
    BSBoardObject * board = [[BSBoardObject alloc] initWithPieces:pieces width:4 height:4];
    boardView = [[BSBoardView alloc] initWithFrame:CGRectMake(4, 48, 312, 312) board:board];
    [boardView setDelegate:self];
    [self.view addSubview:boardView];
}

- (void)setupTitleBar {
    navItem = [[UINavigationItem alloc] initWithTitle:@"BoggleSolve"];
    
    editButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit
                                                               target:self action:@selector(editButton:)];
    doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                               target:self action:@selector(doneButton:)];
    solveButton = [[UIBarButtonItem alloc] initWithTitle:@"Solve" style:UIBarButtonItemStylePlain
                                                  target:self action:@selector(solveButton:)];
    [navItem setLeftBarButtonItem:solveButton];
    [navItem setRightBarButtonItem:editButton];
    
    titleBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
    [titleBar pushNavigationItem:navItem animated:NO];
    
    [self.view addSubview:titleBar];
}

#pragma mark - Events -

- (void)editButton:(id)sender {
    [self beginEditUI];
}

- (void)doneButton:(id)sender {
    [self endEditUI];
}

- (void)solveButton:(id)sender {
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

#pragma mark - Board -

- (BOOL)boardViewShouldStartEditing:(BSBoardView *)boardView {
    [self beginEditUI];
    return YES;
}

#pragma mark - Editing -

- (void)beginEditUI {
    if (!editingEntry) {
        editingEntry = [[UITextField alloc] initWithFrame:CGRectMake(0, -20, 1, 1)];
        [editingEntry setKeyboardType:UIKeyboardTypeAlphabet];
        [editingEntry setDelegate:self];
    }
    [self.view addSubview:editingEntry];
    [editingEntry becomeFirstResponder];
    [boardView setBoardState:BSBoardViewStateEditing];
    [boardView setEditingCell:0];
    [boardView setNeedsDisplay];
    [navItem setRightBarButtonItem:doneButton animated:YES];
    // TODO: resize the board
}

- (void)endEditUI {
    [editingEntry resignFirstResponder];
    [editingEntry removeFromSuperview];
    [editingEntry setText:@""];
    [boardView setBoardState:BSBoardViewStateDefault];
    [boardView setNeedsDisplay];
    [navItem setRightBarButtonItem:editButton animated:YES];
    // TODO: resize the board
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self endEditUI];
    return NO;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if ([string length] == 1) {
        unichar letter = tolower([string characterAtIndex:0]);
        [boardView setLetterAtEditingIndex:letter];
    }
    return NO;
}

@end
