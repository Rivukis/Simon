//
//  RIVLevel.m
//  Simon
//
//  Created by Brian Radebaugh on 8/10/14.
//  Copyright (c) 2014 CleverKnot. All rights reserved.
//

#import "RIVLevel.h"

@interface RIVLevel ()

@property (assign, nonatomic) NSInteger number;
@property (assign, nonatomic) NSInteger numberOfSubLevels;
@property (strong, nonatomic) NSDictionary *colorCountReference;

@end

@implementation RIVLevel

+ (RIVLevel *)baseGame
{
    RIVLevel *level = [RIVLevel new];
    level.number = 0;
    level.numberOfSubLevels = 500;
    level.colorCountReference = @{@1: @4, @5: @5, @6: @6};
    
    return level;
}

+ (RIVLevel *)levelNumber:(NSInteger)number
{
    RIVLevel *level = [RIVLevel new];
    level.number = number;
    switch (number) {
        case 0:
            return [self baseGame];
            break;
        case 1:
            level.numberOfSubLevels = 4;
            level.colorCountReference = @{@1: @4};
            break;
        case 2:
            level.numberOfSubLevels = 6;
            level.colorCountReference = @{@1: @5};
            break;
        case 3:
            level.numberOfSubLevels = 10;
            level.colorCountReference = @{@1: @4, @5: @5};
            break;
        case 4:
            level.numberOfSubLevels = 5;
            level.colorCountReference = @{@1: @6};
            break;
        case 5:
            level.numberOfSubLevels = 15;
            level.colorCountReference = @{@1: @4, @5: @5, @10: @6};
            break;
        default:
            return [self baseGame];
            break;
    }
    
    return level;
}


#pragma mark - Lazy Instantiation


- (NSDictionary *)colorCountReference
{
    if (!_colorCountReference) _colorCountReference = [NSDictionary new];
    return _colorCountReference;
}

@end
