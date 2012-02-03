//
//  ViewController.m
//  BoggleSolver
//
//  Created by Alex Nichol on 2/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    // NSString * filePath = [[NSBundle mainBundle] pathForResource:@"dictionary" ofType:@"txt"];
    // BSDictionaryObject * dictionary = [[BSDictionaryObject alloc] initWithFile:filePath];
    
    NSArray * pieces = [NSArray arrayWithObjects:@"e", @"x", @"a", @"m",
                                                 @"h", @"e", @"l", @"p",
                                                 @"e", @"a", @"d", @"s",
                                                 @"s", @"c", @"a", @"m", nil];
    BSBoardObject * board = [[BSBoardObject alloc] initWithPieces:pieces width:4 height:4];
    boardView = [[BSBoardView alloc] initWithFrame:CGRectMake(0, 0, 320, 320) board:board];
    [self.view addSubview:boardView];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
