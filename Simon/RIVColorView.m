//
//  RIVColorView.m
//  Simon
//
//  Created by Brian Radebaugh on 8/7/14.
//  Copyright (c) 2014 CleverKnot. All rights reserved.
//

#import "RIVColorView.h"
#import "RIVViewController.h"

@interface RIVColorView ()

@property (strong, nonatomic) UIColor *highlightedColor;
@property (strong, nonatomic) UIColor *unhighlightedColor;

@end

@implementation RIVColorView

- (instancetype)initWithHighlightedColor:(UIColor *)highlightedColor unhighlightedColor:(UIColor *)unhighlightedColor frame:(CGRect)frame
{
    self = [self initWithFrame:frame];
    self.layer.cornerRadius = 0.15 * frame.size.height;
    
    self.highlightedColor = highlightedColor;
    self.unhighlightedColor = unhighlightedColor;
    self.isHighlighted = NO;
    
    [self setupGesture];
    
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (void)setupGesture
{
    UILongPressGestureRecognizer *longPressedGesture = [[UILongPressGestureRecognizer alloc]
                                                        initWithTarget:self action:@selector(touchWithLongPressGesture:)];
    longPressedGesture.minimumPressDuration = 0.001;
    [self addGestureRecognizer:longPressedGesture];
}


#pragma mark - UIGesture Helper Methods


- (void)touchWithLongPressGesture:(UILongPressGestureRecognizer *)longPressGesture
{
    if (!self.isSelectable) {
        [self removeGestureRecognizer:longPressGesture];
        [self setupGesture];
        return;
    }
    
    BOOL isInView = [self gestureIsInAttachedView:[longPressGesture locationInView:longPressGesture.view]];
    if (isInView) {
        self.isHighlighted = YES;
        if (longPressGesture.state == UIGestureRecognizerStateEnded) {
            self.isHighlighted = NO;
            [self.delegate touchUpEventOnView:self];
        }
    } else {
        self.isHighlighted = NO;
    }
}

- (BOOL)gestureIsInAttachedView:(CGPoint)location
{
    if (location.x < 0 || location.x > self.frame.size.width) return NO;
    if (location.y < 0 || location.y > self.frame.size.height) return NO;
    
    return YES;
}

#pragma mark - Helper Methods

- (void)setIsHighlighted:(BOOL)isHighlighted
{
    if (isHighlighted) {
        self.backgroundColor = self.highlightedColor;
    } else {
        self.backgroundColor = self.unhighlightedColor;
    }
    _isHighlighted = isHighlighted;
}

- (void)makeHighlighted
{
    self.isHighlighted = YES;
}

- (void)makeUnhighlighted
{
    self.isHighlighted = NO;
}

@end
