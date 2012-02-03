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

@synthesize boardState;
@synthesize solution;
@synthesize editingCell;

- (id)initWithFrame:(CGRect)frame board:(BSBoardObject *)aBoard {
    if ((self = [super init])) {
        board = aBoard;
        boardState = BSBoardViewStateDefault;
    }
    return self;
}

- (void)animateToFrame:(CGRect)aFrame {
    [UIView animateWithDuration:0.5 animations:^ {
        [self setFrame:aFrame];
    }];
}

#pragma mark - Drawing -

- (void)drawRect:(CGRect)rect {
    CGRect bounds = self.bounds;
    CGRect inner = CGRectMake(4, 4, bounds.size.width - 8, bounds.size.height - 8);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetRGBFillColor(context, 0, 0, 0, 1);
    CGContextFillRect(context, bounds);
    CGContextSetRGBFillColor(context, 1, 1, 1, 1);
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
            NSString * labelString = [NSString stringWithFormat:@"%c", letter];
            UIFont * labelFont = [UIFont boldSystemFontOfSize:18];
            CGSize labelSize = [labelString sizeWithFont:labelFont];
            CGRect labelFrame = CGRectMake(cellFrame.size.width / 2 - labelSize.width / 2 + cellFrame.origin.x,
                                           cellFrame.size.height / 2 - labelSize.height / 2 + cellFrame.origin.y,
                                           labelSize.width, labelSize.height);
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
                return [[UIColor colorWithRed:0.9 green:0.9 blue:0 alpha:1] CGColor];
            }
            break;
        case BSBoardViewStateEditing:
        {
            NSUInteger xcoord = editingCell % [board width];
            NSUInteger ycoord = editingCell / [board width];
            if (x == xcoord && y == ycoord) {
                return [[UIColor colorWithRed:0.3 green:0.35 blue:0.98 alpha:1] CGColor];
            }
            break;
        }
        default:
            break;
    }
    return nil;
}

@end
