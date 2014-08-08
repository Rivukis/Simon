//
//  RIVGameBoard.m
//  Simon
//
//  Created by Brian Radebaugh on 8/6/14.
//  Copyright (c) 2014 CleverKnot. All rights reserved.
//

#import "RIVGameBoard.h"

const NSInteger fifthColorLevel = 5;
const NSInteger sixthColorLevel = 10;

@interface RIVGameBoard ()

@property (strong, nonatomic) NSMutableArray *colorSequence; // of RIVGameBoardPlayOutCome
@property (assign, nonatomic) NSInteger nextColorIndex;
@property (assign, nonatomic) NSInteger highestLevelCompleted;

@property (assign, nonatomic) BOOL gameIsOver;

@end

@implementation RIVGameBoard

- (id)init
{
    self = [super init];
    if (self) {
        self.highestLevelCompleted = [[NSUserDefaults standardUserDefaults] integerForKey:@"highestLevelCompleted"];
        self.gameIsOver = YES;
    }
    return self;
}

- (void)newGame
{
    self.gameIsOver = NO;
    self.colorSequence = [NSMutableArray new];
    [self advanceToNextRound];
}

- (RIVGameBoardPlayOutcome)playColor:(RIVGameBoardColor)color
{
    if (self.gameIsOver) return RIVGameBoardPlayOutcomeNotPlayable;
    
    if (color == [self.colorSequence[self.nextColorIndex] integerValue]) {
        self.nextColorIndex++;
        if (self.nextColorIndex >= self.colorSequence.count) {
            [self advanceToNextRound];
            return RIVGameBoardPlayOutcomeLevelComplete;
        } else {
            return RIVGameBoardPlayOutcomeCorrect;
        }
    }
    
    self.gameIsOver = YES;
    return RIVGameBoardPlayOutcomeIncorrect;
}

- (void)advanceToNextRound
{
    NSInteger numberOfColorOptions = 4;
    if (self.colorSequence.count + 1 >= fifthColorLevel) numberOfColorOptions++;
    if (self.colorSequence.count + 1 >= sixthColorLevel) numberOfColorOptions++;
    
    RIVGameBoardColor colorToAdd = arc4random_uniform(numberOfColorOptions);
    [self.colorSequence addObject:@(colorToAdd)];
    
    if (self.highestLevelCompleted < self.colorSequence.count) {
        self.highestLevelCompleted = self.colorSequence.count;
        [[NSUserDefaults standardUserDefaults] setInteger:self.highestLevelCompleted forKey:@"highestLevelCompleted"];
    }
    
    self.nextColorIndex = 0;
}


#pragma mark - Lazy Instantiation


- (NSMutableArray *)colorSequence
{
    if (!_colorSequence) _colorSequence = [NSMutableArray new];
    return _colorSequence;
}

@end
