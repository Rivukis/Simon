//
//  RIVGame.h
//  Simon
//
//  Created by Brian Radebaugh on 8/8/14.
//  Copyright (c) 2014 CleverKnot. All rights reserved.
//

#import <Foundation/Foundation.h>
@class RIVLevel;

extern const NSInteger minColorCount;
extern const NSInteger maxColorCount;

typedef NS_ENUM(NSInteger, RIVGameBoardColor) {
    RIVGameBoardColorRed = 1,
    RIVGameBoardColorGreen,
    RIVGameBoardColorBlue,
    RIVGameBoardColorYellow,
    RIVGameBoardColorMagenta,
    RIVGameBoardColorCyan
};

typedef NS_ENUM(NSInteger, RIVGameBoardPlayOutcome) {
    RIVGameBoardPlayOutcomeCorrect = 1,
    RIVGameBoardPlayOutcomeSubLevelComplete,
    RIVGameBoardPlayOutcomeLevelComplete,
    RIVGameBoardPlayOutcomeIncorrect,
    RIVGameBoardPlayOutcomeNotPlayable
};

@interface RIVGame : NSObject

@property (readonly, nonatomic) RIVLevel *currentLevel;
@property (readonly, nonatomic) NSInteger currentSubLevel;
@property (readonly, nonatomic) NSInteger currentColorIndex;
@property (readonly, nonatomic) NSInteger currentColorCount;
@property (readonly, nonatomic) BOOL hasEnded;

@property (readonly, nonatomic) NSInteger highestCompletedLevel;
@property (readonly, nonatomic) NSMutableArray *colorSequence;

- (void)restartGame;
- (void)restartLevel;
- (RIVGameBoardPlayOutcome)playColor:(RIVGameBoardColor)color;

@end