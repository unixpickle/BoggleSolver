//
//  ViewController.m
//  BoggleSolver
//
//  Created by Alex Nichol on 2/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"

@interface ViewController (UIConfiguration)

- (CGRect)boardViewFrame;
- (void)setupTitleBar;
- (void)setupSolutionsTable;

@end

@interface ViewController (Private)

- (void)solveBoardInBackground:(BSBoardObject *)board;
- (void)handleSolutionArray:(NSArray *)solutions;

@end

@implementation ViewController

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

#pragma mark - View Configuration -

- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    // NSString * filePath = [[NSBundle mainBundle] pathForResource:@"dictionary" ofType:@"txt"];
    // BSDictionaryObject * dictionary = [[BSDictionaryObject alloc] initWithFile:filePath];
    
    [self setupTitleBar];
    [self setupSolutionsTable];
    
    NSArray * pieces = [NSArray arrayWithObjects:@"e", @"x", @"a", @"m",
                                                 @"h", @"e", @"l", @"p",
                                                 @"e", @"a", @"d", @"s",
                                                 @"e", @"r", @"e", @"h", nil];
    BSBoardObject * board = [[BSBoardObject alloc] initWithPieces:pieces width:4 height:4];
    boardView = [[BSBoardView alloc] initWithFrame:[self boardViewFrame] board:board];
    [boardView setDelegate:self];
    [self.view addSubview:boardView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification object:nil];
}

- (CGRect)boardViewFrame {
    return CGRectMake(40, 54, self.view.frame.size.width - 80, self.view.frame.size.width - 80);
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

- (void)setupSolutionsTable {
    CGFloat yValue = CGRectGetMaxY([self boardViewFrame]) + 10;
    
    solutionTable = [[UITableView alloc] initWithFrame:CGRectMake(10, yValue, 300, self.view.frame.size.height - yValue - 10) style:UITableViewStylePlain];
    [[solutionTable layer] setCornerRadius:5];
    [solutionTable setDataSource:self];
    [self.view addSubview:solutionTable];
}

#pragma mark - Events -

- (void)editButton:(id)sender {
    [self beginEditUI];
}

- (void)doneButton:(id)sender {
    [self endEditUI];
}

- (void)solveButton:(id)sender {
    if ([[BSLoadingController sharedLoadingController] isDisplayingScreen]) return;
    [[BSLoadingController sharedLoadingController] showLoadingScreen];
    BSBoardObject * boardCopy = [boardView board];
    [NSThread detachNewThreadSelector:@selector(solveBoardInBackground:) toTarget:self withObject:boardCopy];
}

- (void)solveBoardInBackground:(BSBoardObject *)board {
    @autoreleasepool {
        NSString * filePath = [[NSBundle mainBundle] pathForResource:@"dictionary" ofType:@"txt"];
        BSDictionaryObject * dictionary = [[BSDictionaryObject alloc] initWithFile:filePath];

        NSArray * solutionArray = [board solutionsForDictionary:dictionary];
        [self performSelectorOnMainThread:@selector(handleSolutionArray:) withObject:solutionArray waitUntilDone:YES];
    }
}

- (void)handleSolutionArray:(NSArray *)_solutions {
    solutions = _solutions;
    [solutionTable reloadData];
    [[BSLoadingController sharedLoadingController] closeLoadingScreen];
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
}

- (void)endEditUI {
    [editingEntry resignFirstResponder];
    [editingEntry removeFromSuperview];
    [editingEntry setText:@""];
    [boardView setBoardState:BSBoardViewStateDefault];
    [boardView setNeedsDisplay];
    [navItem setRightBarButtonItem:editButton animated:YES];
}

- (void)keyboardWillShow:(NSNotification *)notification {
    CGRect frame;
    [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] getValue:&frame];
    NSNumber * duration = [[notification userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    // calculate the frame of the board
    CGRect usableRect = CGRectMake(0, 44, self.view.frame.size.width,
                                   self.view.frame.size.height - 44 - frame.size.height);
    CGFloat scaledSize = usableRect.size.height - 20;
    [boardView animateToFrame:CGRectMake(usableRect.size.width / 2 - scaledSize / 2,
                                         usableRect.origin.y + 10, scaledSize, scaledSize)
                     duration:[duration doubleValue]];
}

- (void)keyboardWillHide:(NSNotification *)notification {
    NSNumber * duration = [[notification userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    [boardView animateToFrame:[self boardViewFrame] duration:[duration doubleValue]];
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

#pragma mark - Solutions -

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [solutions count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BSSolutionObject * solution = [solutions objectAtIndex:indexPath.row];
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SolutionCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SolutionCell"];
    }
    cell.textLabel.text = [solution word];
    return cell;
}

@end
