//
//  RIVGameBoard.h
//  Simon
//
//  Created by Brian Radebaugh on 8/6/14.
//  Copyright (c) 2014 CleverKnot. All rights reserved.
//

#import <Foundation/Foundation.h>

extern const NSInteger fifthColorLevel;
extern const NSInteger sixthColorLevel;

typedef NS_ENUM(NSInteger, RIVGameBoardColor) {
    RIVGameBoardColorRed = 0,
    RIVGameBoardColorGreen,
    RIVGameBoardColorBlue,
    RIVGameBoardColorYellow,
    RIVGameBoardColorMagenta,
    RIVGameBoardColorCyan
};

typedef NS_ENUM(NSInteger, RIVGameBoardPlayOutcome) {
    RIVGameBoardPlayOutcomeIncorrect = 1,
    RIVGameBoardPlayOutcomeCorrect,
    RIVGameBoardPlayOutcomeLevelComplete
};

@interface RIVGameBoard : NSObject

@property (readonly, nonatomic) NSMutableArray *colorSequence; // of RIVGameBoardPlayOutCome
@property (readonly, nonatomic) NSInteger nextColorIndex;
@property (readonly, nonatomic) NSInteger highestLevelCompleted;

- (void)newGame;
- (RIVGameBoardPlayOutcome)playColor:(RIVGameBoardColor)color;

@end
