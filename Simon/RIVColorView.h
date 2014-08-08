//
//  RIVColorView.h
//  Simon
//
//  Created by Brian Radebaugh on 8/7/14.
//  Copyright (c) 2014 CleverKnot. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RIVColorView;

@protocol RIVColorViewDelegate <NSObject>

@optional
- (void)touchUpEventOnView:(RIVColorView *)view;

@end

@interface RIVColorView : UIView

@property (unsafe_unretained, nonatomic) id<RIVColorViewDelegate> delegate;
@property (assign, nonatomic) BOOL isSelectable;
@property (assign, nonatomic) BOOL isHighlighted;

- (instancetype)initWithHighlightedColor:(UIColor *)highlightedColor unhighlightedColor:(UIColor *)unhighlightedColor frame:(CGRect)frame;
- (void)makeHighlighted;
- (void)makeUnhighlighted;

@end