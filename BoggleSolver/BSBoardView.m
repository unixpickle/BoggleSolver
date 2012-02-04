//
//  BSBoardView.m
//  BoggleSolver
//
//  Created by Alex Nichol on 2/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BSBoardView.h"

@interface BSBoardView (Drawing)

- (CGColorRef)backgroundForCellAtX:(NSUInteger)x y:(NSUInteger)y;

@end

@implementation BSBoardView

@synthesize board;
@synthesize delegate;

@synthesize boardState;
@synthesize solution;
@synthesize editingCell;

- (id)initWithFrame:(CGRect)frame board:(BSBoardObject *)aBoard {
    if ((self = [super initWithFrame:frame])) {
        board = aBoard;
        boardState = BSBoardViewStateDefault;
    }
    return self;
}

- (void)animateToFrame:(CGRect)aFrame {
    [self animateToFrame:aFrame duration:0.5];
}

- (void)animateToFrame:(CGRect)aFrame duration:(NSTimeInterval)duration {
    self.contentMode = UIViewContentModeRedraw;
    self.layer.needsDisplayOnBoundsChange = YES;
    self.clipsToBounds = YES;
    
    [UIView animateWithDuration:duration animations:^ {
        [self setFrame:aFrame];
    }];
}

- (void)setLetterAtEditingIndex:(char)aLetter {
    NSUInteger x = editingCell % [board width];
    NSUInteger y = editingCell / [board width];
    [board setLetter:aLetter atX:x y:y];
    editingCell++;
    if (editingCell >= [board width] * [board height]) {
        editingCell = 0;
    }
    [self setNeedsDisplay];
}

#pragma mark - Drawing -

- (void)drawRect:(CGRect)rect {
    CGRect bounds = self.bounds;
    CGRect inner = CGRectMake(4, 4, bounds.size.width - 8, bounds.size.height - 8);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetRGBFillColor(context, 166.0 / 255.0, 72.0 / 255.0, 0, 1);
    CGContextFillRect(context, bounds);
    CGContextSetRGBFillColor(context, 1.0, 208.0 / 255.0, 115.0 / 255.0, 1);
    CGContextFillRect(context, inner);
    
    CGFloat cellWidth = inner.size.width / (CGFloat)[board width];
    CGFloat cellHeight = inner.size.height / (CGFloat)[board height];
    
    for (NSUInteger x = 0; x < [board width]; x++) {
        for (NSUInteger y = 0; y < [board height]; y++) {
            CGRect cellFrame = CGRectMake(4 + cellWidth * (CGFloat)x,
                                          4 + cellHeight * (CGFloat)y,
                                          cellWidth, cellHeight);
            
            CGColorRef bgColor = [self backgroundForCellAtX:x y:y];
            if (bgColor) {
                CGContextSetFillColorWithColor(context, bgColor);
                CGContextFillRect(context, cellFrame);
            }
            
            char letter = [board letterAtX:x y:y];
            NSString * labelString = [NSString stringWithFormat:@"%c", toupper(letter)];
            if (letter == 'q') {
                labelString = @"Qu";
            }
            UIFont * labelFont = [UIFont boldSystemFontOfSize:18];
            CGSize labelSize = [labelString sizeWithFont:labelFont];
            CGRect labelFrame = CGRectMake(cellFrame.size.width / 2 - labelSize.width / 2 + cellFrame.origin.x,
                                           cellFrame.size.height / 2 - labelSize.height / 2 + cellFrame.origin.y,
                                           labelSize.width, labelSize.height);
            CGContextSetRGBFillColor(context, 0, 0, 0, 1);
            [labelString drawInRect:labelFrame withFont:labelFont];
        }
    }
}

- (CGColorRef)backgroundForCellAtX:(NSUInteger)x y:(NSUInteger)y {
    switch (boardState) {
        case BSBoardViewStateDefault:
            break;
        case BSBoardViewStateAnswer:
            if (!solution) break;
            if ([solution includesX:x andY:y]) {
                return [[UIColor colorWithRed:1 green:(191.0 / 255.0) blue:0 alpha:1] CGColor];
            }
            break;
        case BSBoardViewStateEditing:
        {
            NSUInteger xcoord = editingCell % [board width];
            NSUInteger ycoord = editingCell / [board width];
            if (x == xcoord && y == ycoord) {
                return [[UIColor colorWithRed:1 green:(191.0 / 255.0) blue:0 alpha:1] CGColor];
            }
            break;
        }
        default:
            break;
    }
    return nil;
}

#pragma mark - Editing -

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    CGPoint location = [[touches anyObject] locationInView:self];
    NSUInteger x = floor(location.x / (self.frame.size.width / (CGFloat)[board width]));
    NSUInteger y = floor(location.y / (self.frame.size.height / (CGFloat)[board height]));
    
    if (boardState == BSBoardViewStateDefault || boardState == BSBoardViewStateAnswer) {
        if ([delegate boardViewShouldStartEditing:self]) {
            [self setBoardState:BSBoardViewStateEditing];
            editingCell = y * [board width] + x;
            [self setNeedsDisplay];
        }
    } else if (boardState == BSBoardViewStateEditing) {
        editingCell = y * [board width] + x;
        [self setNeedsDisplay];
    }
}

@end
