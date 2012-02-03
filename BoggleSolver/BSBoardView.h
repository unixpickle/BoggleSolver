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

@class BSBoardView;

@protocol BSBoardViewDelegate

- (BOOL)boardViewShouldStartEditing:(BSBoardView *)boardView;

@end

@interface BSBoardView : UIView {
    BSBoardObject * board;
    
    BSBoardViewState boardState;
    BSSolutionObject * solution;
    NSUInteger editingCell;
    
    __weak id<BSBoardViewDelegate> delegate;
}

@property (readonly) BSBoardObject * board;
@property (nonatomic, weak) id<BSBoardViewDelegate> delegate;

@property (readwrite) BSBoardViewState boardState;
@property (nonatomic, strong) BSSolutionObject * solution;
@property (readwrite) NSUInteger editingCell;

- (id)initWithFrame:(CGRect)frame board:(BSBoardObject *)aBoard;
- (void)animateToFrame:(CGRect)aFrame;
- (void)setLetterAtEditingIndex:(char)aLetter;

@end
