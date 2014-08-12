//
//  RIVLevel.h
//  Simon
//
//  Created by Brian Radebaugh on 8/10/14.
//  Copyright (c) 2014 CleverKnot. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RIVLevel : NSObject

@property (readonly, nonatomic) NSInteger number;
@property (readonly, nonatomic) NSInteger numberOfSubLevels;
@property (readonly, nonatomic) NSDictionary *colorCountReference;

+ (RIVLevel *)levelNumber:(NSInteger)number;

@end