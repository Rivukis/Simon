//
//  RIVViewController.m
//  Simon
//
//  Created by Brian Radebaugh on 8/6/14.
//  Copyright (c) 2014 CleverKnot. All rights reserved.
//

#import "RIVViewController.h"
#import "RIVGameBoard.h"

@interface RIVViewController ()

@property (weak, nonatomic) IBOutlet UILabel *highestLevelAchievedLable;

@property (strong, nonatomic) RIVGameBoard *gameboard;

@end

@implementation RIVViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.gameboard newGame];
    self.highestLevelAchievedLable.text = [NSString stringWithFormat:@"Highest Level Achieved: %d", self.gameboard.highestLevelCompleted];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


#pragma mark - Play Buttons


- (IBAction)newGamePressed:(UIButton *)sender
{
    [self.gameboard newGame];
    NSLog(@"%@", self.gameboard.colorSequence.description);
}

- (IBAction)redPressed:(UIButton *)sender {[self colorPressed:sender];}
- (IBAction)greenPressed:(UIButton *)sender {[self colorPressed:sender];}
- (IBAction)bluePressed:(UIButton *)sender {[self colorPressed:sender];}
- (IBAction)yellowPressed:(UIButton *)sender {[self colorPressed:sender];}
- (IBAction)magentaPressed:(UIButton *)sender {[self colorPressed:sender];}
- (IBAction)cyanPressed:(UIButton *)sender {[self colorPressed:sender];}

- (void)colorPressed:(UIButton *)sender
{
    const CGFloat *components = CGColorGetComponents(sender.backgroundColor.CGColor);
    float newRed = (components[0] > 0.5) ? 1.0 : 0.0;
    float newGreen = (components[1] > 0.5) ? 1.0 : 0.0;
    float newBlue = (components[2] > 0.5) ? 1.0 : 0.0;
    
    NSLog(@"was: %f, %f, %f", components[0], components[1], components[2]);
    
    sender.backgroundColor = [UIColor colorWithRed:newRed green:newGreen blue:newBlue alpha:1.0];
}

- (IBAction)colorReleased:(UIButton *)sender
{
    const CGFloat *components = CGColorGetComponents(sender.backgroundColor.CGColor);
    float newRed = (components[0] > 0.5) ? 0.784 : 0.0;
    float newGreen = (components[1] > 0.5) ? 0.784 : 0.0;
    float newBlue = (components[2] > 0.5) ? 0.784 : 0.0;
    
    NSLog(@"is: %f, %f, %f", components[0], components[1], components[2]);
    
    sender.backgroundColor = [UIColor colorWithRed:newRed green:newGreen blue:newBlue alpha:1.0];
    
    RIVGameBoardPlayOutcome outcome = [self.gameboard playColor:sender.tag];
    [self reflectOutcome:outcome];
}

- (void)reflectOutcome:(RIVGameBoardPlayOutcome)outcome
{
    switch (outcome) {
        case RIVGameBoardPlayOutcomeIncorrect:
            [self.gameboard newGame];
            break;
        case RIVGameBoardPlayOutcomeCorrect:
            break;
        case RIVGameBoardPlayOutcomeLevelComplete:
            self.highestLevelAchievedLable.text = [NSString stringWithFormat:@"Highest Level Achieved: %d", self.gameboard.highestLevelCompleted];
            NSLog(@"%@", self.gameboard.colorSequence.description);
            break;
    }
}


#pragma mark - Lazy Instantiation


- (RIVGameBoard *)gameboard
{
    if (!_gameboard) _gameboard = [[RIVGameBoard alloc] init];
    return _gameboard;
}

@end
