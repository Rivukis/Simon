//
//  RIVViewController.m
//  Simon
//
//  Created by Brian Radebaugh on 8/6/14.
//  Copyright (c) 2014 CleverKnot. All rights reserved.
//

#import "RIVViewController.h"
//#import "RIVGameBoard.h"
#import "RIVGame.h"
#import "RIVLevel.h"
#import "UIColor+RivCustomColors.h"
#import "RIVColorView.h"

@interface RIVViewController () <RIVColorViewDelegate> {
    NSInteger numberOfRuns;
}

@property (weak, nonatomic) IBOutlet UILabel *highestLevelAchievedLabel;
@property (weak, nonatomic) IBOutlet UILabel *currentLevelLabel;
@property (weak, nonatomic) IBOutlet UIButton *restartGameButton;

//@property (strong, nonatomic) RIVGameBoard *gameboard;
@property (strong, nonatomic) RIVGame *game;
@property (strong, nonatomic) RIVColorView *redView;
@property (strong, nonatomic) RIVColorView *greenView;
@property (strong, nonatomic) RIVColorView *blueView;
@property (strong, nonatomic) RIVColorView *yellowView;
@property (strong, nonatomic) RIVColorView *magentaView;
@property (strong, nonatomic) RIVColorView *cyanView;
@property (assign, nonatomic) NSInteger colorsInView;

@property (strong, nonatomic) NSTimer *showTimer;

@end

@implementation RIVViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"highestLevelCompleted"];
    
//    self.gameboard = [[RIVGameBoard alloc] init];
//    self.highestLevelAchievedLabel.text = [NSString stringWithFormat:@"Highest Level Achieved: %d", self.gameboard.highestLevelCompleted];
    
    self.game = [[RIVGame alloc] init];
    self.highestLevelAchievedLabel.text = [NSString stringWithFormat:@"Highest Level Achieved: %d", self.game.highestCompletedLevel];
    
    self.restartGameButton.hidden = YES;
    self.highestLevelAchievedLabel.hidden = YES;
    self.currentLevelLabel.hidden = YES;
    
    [self setupColorViews];
    [self makeColorViewsSelectable:NO];
//    [self moveFirstFourColorViewsInPlace];
    [self showFourColorsWithCompletion:^{
        self.restartGameButton.hidden = NO;
        self.currentLevelLabel.hidden = NO;
        self.highestLevelAchievedLabel.hidden = NO;
        NSLog(@"it works");
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)setupColorViews
{
    self.redView = [[RIVColorView alloc] initWithHighlightedColor:[UIColor highlightedRed]
                                               unhighlightedColor:[UIColor unhighlightedRed]
                                                            frame:CGRectMake(20, 118 - 400, 130, 130)];
    self.redView.tag = 1;
    self.redView.delegate = self;
    [self.view addSubview:self.redView];
    
    self.greenView = [[RIVColorView alloc] initWithHighlightedColor:[UIColor highlightedGreen]
                                                 unhighlightedColor:[UIColor unhighlightedGreen]
                                                              frame:CGRectMake(170 + 400, 118, 130, 130)];
    self.greenView.tag = 2;
    self.greenView.delegate = self;
    [self.view addSubview:self.greenView];
    
    self.blueView = [[RIVColorView alloc] initWithHighlightedColor:[UIColor highlightedBlue]
                                                 unhighlightedColor:[UIColor unhighlightedBlue]
                                                              frame:CGRectMake(20 - 400, 268, 130, 130)];
    self.blueView.tag = 3;
    self.blueView.delegate = self;
    [self.view addSubview:self.blueView];
    
    self.yellowView = [[RIVColorView alloc] initWithHighlightedColor:[UIColor highlightedYellow]
                                                unhighlightedColor:[UIColor unhighlightedYellow]
                                                             frame:CGRectMake(170, 268 + 400, 130, 130)];
    self.yellowView.tag = 4;
    self.yellowView.delegate = self;
    [self.view addSubview:self.yellowView];
    
    self.magentaView = [[RIVColorView alloc] initWithHighlightedColor:[UIColor highlightedMagenta]
                                                unhighlightedColor:[UIColor unhighlightedMagenta]
                                                             frame:CGRectMake(20 + 75, 418 + 400, 130, 130)];
    self.magentaView.tag = 5;
    self.magentaView.delegate = self;
    [self.view addSubview:self.magentaView];
    
    self.cyanView = [[RIVColorView alloc] initWithHighlightedColor:[UIColor highlightedCyan]
                                                   unhighlightedColor:[UIColor unhighlightedCyan]
                                                                frame:CGRectMake(170 + 400, 418, 130, 130)];
    self.cyanView.tag = 6;
    self.cyanView.delegate = self;
    [self.view addSubview:self.cyanView];
}


#pragma mark - Color View Methods


- (void)showFourColorsWithCompletion:(void (^)())completion
{
    [UIView animateWithDuration:1.0 animations:^{
        self.redView.frame = CGRectMake(20, 118, 130, 130);
        self.greenView.frame = CGRectMake(170, 118, 130, 130);
        self.blueView.frame = CGRectMake(20, 268, 130, 130);
        self.yellowView.frame = CGRectMake(170, 268, 130, 130);
        self.magentaView.frame = CGRectMake(20 + 75, 418 + 400, 130, 130);
        self.cyanView.frame = CGRectMake(170 + 400, 418, 130, 130);
    } completion:^(BOOL finished) {
        self.colorsInView = 4;
        if (completion) completion();
    }];
}

- (void)showFiveColorsWithCompletion:(void (^)())completion
{
    [UIView animateWithDuration:1.0 animations:^{
        self.redView.frame = CGRectMake(20, 118, 130, 130);
        self.greenView.frame = CGRectMake(170, 118, 130, 130);
        self.blueView.frame = CGRectMake(20, 268, 130, 130);
        self.yellowView.frame = CGRectMake(170, 268, 130, 130);
        self.magentaView.frame = CGRectMake(95, 418, 130, 130);
        self.cyanView.frame = CGRectMake(170 + 400, 418, 130, 130);
    } completion:^(BOOL finished) {
        self.colorsInView = 5;
        if (completion) completion();
    }];
}

- (void)showSixColorsWithCompletion:(void (^)())completion
{
    [UIView animateWithDuration:1.0 animations:^{
        self.redView.frame = CGRectMake(20, 118, 130, 130);
        self.greenView.frame = CGRectMake(170, 118, 130, 130);
        self.blueView.frame = CGRectMake(20, 268, 130, 130);
        self.yellowView.frame = CGRectMake(170, 268, 130, 130);
        self.magentaView.frame = CGRectMake(20, 418, 130, 130);
        self.cyanView.frame = CGRectMake(170, 418, 130, 130);
    } completion:^(BOOL finished) {
        self.colorsInView = 6;
        if (completion) completion();
    }];
}

- (void)makeColorViewsSelectable:(BOOL)isSelectable
{
    self.redView.isSelectable = isSelectable;
    self.greenView.isSelectable = isSelectable;
    self.blueView.isSelectable = isSelectable;
    self.yellowView.isSelectable = isSelectable;
    self.magentaView.isSelectable = isSelectable;
    self.cyanView.isSelectable = isSelectable;
}

- (void)makeColorViewsHighlighted:(BOOL)isHighlighted
{
    self.redView.isHighlighted = isHighlighted;
    self.greenView.isHighlighted = isHighlighted;
    self.blueView.isHighlighted = isHighlighted;
    self.yellowView.isHighlighted = isHighlighted;
    self.magentaView.isHighlighted = isHighlighted;
    self.cyanView.isHighlighted = isHighlighted;
}


#pragma mark - User Actions


- (IBAction)newGamePressed:(UIButton *)sender
{
    [self.showTimer invalidate];
    [self makeColorViewsHighlighted:NO];
    
    [UIView animateWithDuration:1.5 animations:^{
        self.magentaView.frame = CGRectMake(20 + 75, 418 + 400, 130, 130);
        self.cyanView.frame = CGRectMake(170 + 400, 418, 130, 130);
    } completion:^(BOOL finished) {
        self.currentLevelLabel.text = @"Current Level: 1";
//        [self.gameboard newGame];
        [self.game restartGame];
        self.view.backgroundColor = [UIColor yellowColor];
        [self showGameSequence];
    }];
}


#pragma mark - RIVColorView Delegate && related Helper Methods


- (void)touchUpEventOnView:(RIVColorView *)view
{
//    RIVGameBoardPlayOutcome outcome = [self.gameboard playColor:view.tag];
    RIVGameBoardPlayOutcome outcome = [self.game playColor:view.tag];
    [self reflectOutcome:outcome];
}

- (void)reflectOutcome:(RIVGameBoardPlayOutcome)outcome
{
    switch (outcome) {
        case RIVGameBoardPlayOutcomeIncorrect:
            [self makeColorViewsSelectable:NO];
            self.view.backgroundColor = [UIColor redColor];
            self.currentLevelLabel.text = @"Current Level: 0";
            break;
            
        case RIVGameBoardPlayOutcomeCorrect:
            break;
            
        case RIVGameBoardPlayOutcomeSubLevelComplete:
            [self makeColorViewsSelectable:NO];
            self.view.backgroundColor = [UIColor yellowColor];
            if (self.colorsInView != self.game.currentColorCount) {
                switch (self.game.currentColorCount) {
                    case 4:     {[self showFourColorsWithCompletion:^{[self showGameSequence];}];    break;}
                    case 5:     {[self showFiveColorsWithCompletion:^{[self showGameSequence];}];    break;}
                    case 6:     {[self showSixColorsWithCompletion:^{[self showGameSequence];}];     break;}
                }
            } else {
                [self showGameSequence];
            }
            break;
            
        case RIVGameBoardPlayOutcomeLevelComplete:
//            self.currentLevelLabel.text = [NSString stringWithFormat:@"Current Level: %d", self.gameboard.colorSequence.count - 1];
//            self.highestLevelAchievedLabel.text = [NSString stringWithFormat:@"Highest Level Achieved: %d", self.gameboard.highestLevelCompleted];
//
            
            self.currentLevelLabel.text = [NSString stringWithFormat:@"Current Level: %d", self.game.currentLevel.number];
            self.highestLevelAchievedLabel.text = [NSString stringWithFormat:@"Highest Level Achieved: %d", self.game.highestCompletedLevel];
            
            [self makeColorViewsSelectable:NO];
            self.view.backgroundColor = [UIColor yellowColor];
            if (self.colorsInView != self.game.currentColorCount) {
                switch (self.game.currentColorCount) {
                    case 4:     {[self showFourColorsWithCompletion:^{[self showGameSequence];}];    break;}
                    case 5:     {[self showFiveColorsWithCompletion:^{[self showGameSequence];}];    break;}
                    case 6:     {[self showSixColorsWithCompletion:^{[self showGameSequence];}];     break;}
                }
            } else {
                [self showGameSequence];
            }
            break;
            
        case RIVGameBoardPlayOutcomeNotPlayable:
            NSLog(@"you can't play that");
            break;
    }
}

- (void)showGameSequence
{
    numberOfRuns = 9;
    
    self.showTimer = [NSTimer scheduledTimerWithTimeInterval:0.3 target:self selector:@selector(makeColorViewHighlightedOrNot) userInfo:nil repeats:YES];
    [self.showTimer fire];
}
                        
- (void)makeColorViewHighlightedOrNot
{
    if (numberOfRuns < 10) {
        numberOfRuns++;
        return;
    }
    
    BOOL willHighlight = (numberOfRuns % 2 == 0);
    NSInteger indexOfColor = (numberOfRuns - 10) / 2;
    
//    RIVColorView *colorView = (RIVColorView *)[self.view viewWithTag:[self.gameboard.colorSequence[indexOfColor] integerValue]];
    RIVColorView *colorView = (RIVColorView *)[self.view viewWithTag:[self.game.colorSequence[indexOfColor] integerValue]];
    colorView.isHighlighted = willHighlight;
    
//    if (indexOfColor == self.gameboard.colorSequence.count - 1 && !willHighlight) {
    if (indexOfColor == self.game.colorSequence.count - 1 && !willHighlight) {
        [self.showTimer invalidate];
        [self makeColorViewsSelectable:YES];
        self.view.backgroundColor = [UIColor greenColor];
        return;
    }
    
    numberOfRuns++;
}


@end