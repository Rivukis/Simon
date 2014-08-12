//
//  RIVGame.m
//  Simon
//
//  Created by Brian Radebaugh on 8/8/14.
//  Copyright (c) 2014 CleverKnot. All rights reserved.
//

#import "RIVGame.h"
#import "RIVLevel.h"

const NSInteger minColorCount = 4;
const NSInteger maxColorCount = 6;

@interface RIVGame ()

@property (strong, nonatomic) RIVLevel *currentLevel;
@property (assign, nonatomic) NSInteger currentSubLevel;
@property (assign, nonatomic) NSInteger currentColorIndex;
@property (assign, nonatomic) NSInteger currentColorCount;
@property (assign, nonatomic) BOOL hasEnded;

@property (assign, nonatomic) NSInteger highestCompletedLevel;

@property (strong, nonatomic) NSMutableArray *colorSequence;

@end

@implementation RIVGame

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self restartGame];
    }
    return self;
}

- (RIVGameBoardPlayOutcome)playColor:(RIVGameBoardColor)color
{
    if (self.hasEnded) return RIVGameBoardPlayOutcomeNotPlayable;
    
    if (color != [self.colorSequence[self.currentColorIndex] integerValue]) {
        self.hasEnded = YES;
        return RIVGameBoardPlayOutcomeIncorrect;
    }
    
    self.currentColorIndex++;
    if (self.currentColorIndex < self.colorSequence.count) return RIVGameBoardPlayOutcomeCorrect;
    
    [self advanceToNextSubLevel];
    if (self.currentSubLevel == 1) return RIVGameBoardPlayOutcomeLevelComplete;
    return RIVGameBoardPlayOutcomeSubLevelComplete;
}

- (void)advanceToNextSubLevel
{
    if (self.currentSubLevel + 1 > self.currentLevel.numberOfSubLevels) [self advanceToNextLevel];
    self.currentSubLevel++;
    
    NSNumber *newColorCount = self.currentLevel.colorCountReference[@(self.currentSubLevel)];
    if (newColorCount) {
        self.currentColorCount = newColorCount.integerValue;
    } else if (self.currentColorCount == 0) {
        self.currentColorCount = minColorCount;
    }
    
    RIVGameBoardColor colorToAdd = arc4random_uniform(self.currentColorCount) + 1;
    [self.colorSequence addObject:@(colorToAdd)];
    
    self.currentColorIndex = 0;
}

- (void)advanceToNextLevel
{
    if (self.highestCompletedLevel < self.currentLevel.number) {
        self.highestCompletedLevel = self.currentLevel.number;
        [[NSUserDefaults standardUserDefaults] setInteger:self.highestCompletedLevel forKey:@"highestCompletedLevel"];
    }
    
    self.currentLevel = [RIVLevel levelNumber:self.currentLevel.number + 1];
    self.currentSubLevel = 0;
    self.currentColorCount = 0;
    self.colorSequence = [NSMutableArray new];
}

- (void)restartGame
{
    self.currentLevel = [RIVLevel levelNumber:1];
    [self restartLevel];
}

- (void)restartLevel
{
    self.currentSubLevel = 0;
    self.currentColorCount = 0;
    self.colorSequence = [NSMutableArray new];
    self.hasEnded = NO;
    [self advanceToNextSubLevel];
}


#pragma mark - Lazy Instantiation


- (NSMutableArray *)colorSequence
{
    if (!_colorSequence) _colorSequence = [NSMutableArray new];
    return _colorSequence;
}

@end