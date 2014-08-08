//
//  UIColor+RivCustomColors.m
//  Simon
//
//  Created by Brian Radebaugh on 8/7/14.
//  Copyright (c) 2014 CleverKnot. All rights reserved.
//

#import "UIColor+RivCustomColors.h"

@implementation UIColor (RivCustomColors)

+ (UIColor *)unhighlightedRed {return [UIColor colorWithRed:150.0/255.0 green:0.0 blue:0.0 alpha:1.0];}
+ (UIColor *)highlightedRed {return [UIColor colorWithRed:1.0 green:0.0 blue:0.0 alpha:1.0];}

+ (UIColor *)unhighlightedGreen {return [UIColor colorWithRed:0.0 green:150.0/255.0 blue:0.0 alpha:1.0];}
+ (UIColor *)highlightedGreen {return [UIColor colorWithRed:0.0 green:1.0 blue:0.0 alpha:1.0];}

+ (UIColor *)unhighlightedBlue {return [UIColor colorWithRed:0.0 green:0.0 blue:150.0/255.0 alpha:1.0];}
+ (UIColor *)highlightedBlue {return [UIColor colorWithRed:0.0 green:0.0 blue:1.0 alpha:1.0];}

+ (UIColor *)unhighlightedYellow {return [UIColor colorWithRed:150.0/255.0 green:150.0/255.0 blue:0.0 alpha:1.0];}
+ (UIColor *)highlightedYellow {return [UIColor colorWithRed:1.0 green:1.0 blue:0.0 alpha:1.0];}

+ (UIColor *)unhighlightedMagenta {return [UIColor colorWithRed:150.0/255.0 green:0.0 blue:150.0/255.0 alpha:1.0];}
+ (UIColor *)highlightedMagenta {return [UIColor colorWithRed:1.0 green:0.0 blue:1.0 alpha:1.0];}

+ (UIColor *)unhighlightedCyan {return [UIColor colorWithRed:0.0 green:150.0/255.0 blue:150.0/255.0 alpha:1.0];}
+ (UIColor *)highlightedCyan {return [UIColor colorWithRed:0.0 green:1.0 blue:1.0 alpha:1.0];}

@end