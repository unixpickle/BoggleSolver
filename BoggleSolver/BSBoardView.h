//
//  BSBoardView.h
//  BoggleSolver
//
//  Created by Alex Nichol on 2/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BSBoardObject.h"

typedef enum {
    BSBoardViewStateDefault,
    BSBoardViewStateEditing,
    BSBoardViewStateAnswer
} BSBoardViewState;

@interface BSBoardView : UIView {
    BSBoardObject * board;
    
    BSBoardViewState boardState;
    BSSolutionObject * solution;
    NSUInteger editingCell;
}

@property (readonly) BSBoardObject * board;

@property (readwrite) BSBoardViewState boardState;
@property (nonatomic, strong) BSSolutionObject * solution;
@property (readwrite) NSUInteger editingCell;

- (id)initWithFrame:(CGRect)frame board:(BSBoardObject *)aBoard;
- (void)animateToFrame:(CGRect)aFrame;

@end
