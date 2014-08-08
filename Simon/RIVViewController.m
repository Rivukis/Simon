//
//  RIVViewController.m
//  Simon
//
//  Created by Brian Radebaugh on 8/6/14.
//  Copyright (c) 2014 CleverKnot. All rights reserved.
//

#import "RIVViewController.h"
#import "RIVGameBoard.h"
#import "UIColor+RivCustomColors.h"
#import "RIVColorView.h"

@interface RIVViewController () <RIVColorViewDelegate> {
    NSInteger numberOfRuns;
}

@property (weak, nonatomic) IBOutlet UILabel *highestLevelAchievedLabel;
@property (weak, nonatomic) IBOutlet UILabel *currentLevelLabel;
@property (weak, nonatomic) IBOutlet UIButton *restartGameButton;

@property (strong, nonatomic) RIVGameBoard *gameboard;
@property (strong, nonatomic) RIVColorView *redView;
@property (strong, nonatomic) RIVColorView *greenView;
@property (strong, nonatomic) RIVColorView *blueView;
@property (strong, nonatomic) RIVColorView *yellowView;
@property (strong, nonatomic) RIVColorView *magentaView;
@property (strong, nonatomic) RIVColorView *cyanView;

@property (strong, nonatomic) NSTimer *showTimer;

@end

@implementation RIVViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"highestLevelCompleted"];
    
    self.gameboard = [[RIVGameBoard alloc] init];
    self.highestLevelAchievedLabel.text = [NSString stringWithFormat:@"Highest Level Achieved: %d", self.gameboard.highestLevelCompleted];
    
    self.restartGameButton.hidden = YES;
    self.highestLevelAchievedLabel.hidden = YES;
    self.currentLevelLabel.hidden = YES;
    
    [self setupColorViews];
    [self makeColorViewsSelectable:NO];
    [self moveFirstFourColorViewsInPlace];
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


#pragma mark - Helper Methods


- (void)makeColorViewsSelectable:(BOOL)isSelectable
{
    self.redView.isSelectable = isSelectable;
    self.greenView.isSelectable = isSelectable;
    self.blueView.isSelectable = isSelectable;
    self.yellowView.isSelectable = isSelectable;
    self.magentaView.isSelectable = isSelectable;
    self.cyanView.isSelectable = isSelectable;
}

- (void)moveFirstFourColorViewsInPlace
{
    [UIView animateWithDuration:1.0 animations:^{
        self.redView.frame = CGRectMake(20, 118, 130, 130);
        self.greenView.frame = CGRectMake(170, 118, 130, 130);
        self.blueView.frame = CGRectMake(20, 268, 130, 130);
        self.yellowView.frame = CGRectMake(170, 268, 130, 130);
        
    } completion:^(BOOL finished) {
        self.restartGameButton.hidden = NO;
        self.currentLevelLabel.hidden = NO;
        self.highestLevelAchievedLabel.hidden = NO;
//        [self makeColorViewsSelectable:YES];
    }];
}

- (void)moveFifthColorViewInPlace
{
    [UIView animateWithDuration:1.0 animations:^{
        self.magentaView.frame = CGRectMake(95, 418, 130, 130);
    } completion:^(BOOL finished) {
//        [self makeColorViewsSelectable:YES];
    }];
}

- (void)moveSixthColorViewInPlace
{
    [UIView animateWithDuration:1.0 animations:^{
        self.magentaView.frame = CGRectMake(20, 418, 130, 130);
        self.cyanView.frame = CGRectMake(170, 418, 130, 130);
    } completion:^(BOOL finished) {
//        [self makeColorViewsSelectable:YES];
    }];
}


#pragma mark - User Actions


- (IBAction)newGamePressed:(UIButton *)sender
{
    [self.showTimer invalidate];
    
    [UIView animateWithDuration:1.5 animations:^{
        self.magentaView.frame = CGRectMake(20 + 75, 418 + 400, 130, 130);
        self.cyanView.frame = CGRectMake(170 + 400, 418, 130, 130);
    } completion:^(BOOL finished) {
        self.currentLevelLabel.text = @"Current Level: 0";
        [self.gameboard newGame];
        [self showGameSequence];
//        [self makeColorViewsSelectable:YES];
        NSLog(@"%@", self.gameboard.colorSequence.description);
    }];
}


#pragma mark - RIVColorView Delegate && related Helper Methods


- (void)touchUpEventOnView:(RIVColorView *)view
{
    RIVGameBoardPlayOutcome outcome = [self.gameboard playColor:view.tag];
    [self reflectOutcome:outcome];
}

- (void)reflectOutcome:(RIVGameBoardPlayOutcome)outcome
{
    switch (outcome) {
        case RIVGameBoardPlayOutcomeIncorrect:
            [self makeColorViewsSelectable:NO];
            self.currentLevelLabel.text = @"Current Level: 0";
            NSLog(@"game over");
            break;
        case RIVGameBoardPlayOutcomeCorrect:
            break;
        case RIVGameBoardPlayOutcomeLevelComplete:
            self.currentLevelLabel.text = [NSString stringWithFormat:@"Current Level: %d", self.gameboard.colorSequence.count - 1];
            self.highestLevelAchievedLabel.text = [NSString stringWithFormat:@"Highest Level Achieved: %d", self.gameboard.highestLevelCompleted];
            
            if (self.gameboard.colorSequence.count == fifthColorLevel) [self moveFifthColorViewInPlace];
            if (self.gameboard.colorSequence.count == sixthColorLevel) [self moveSixthColorViewInPlace];
            
            [self makeColorViewsSelectable:NO];
            [self showGameSequence];
            break;
        case RIVGameBoardPlayOutcomeNotPlayable:
            NSLog(@"you can't play that");
            break;
    }
}

- (void)showGameSequence
{
    numberOfRuns = 9;
    
    self.showTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(makeColorViewHighlightedOrNot) userInfo:nil repeats:YES];
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
    
    RIVColorView *colorView = (RIVColorView *)[self.view viewWithTag:[self.gameboard.colorSequence[indexOfColor] integerValue]];
    colorView.isHighlighted = willHighlight;
    
    if (indexOfColor == self.gameboard.colorSequence.count - 1 && !willHighlight) {
        [self makeColorViewsSelectable:YES];
        [self.showTimer invalidate];
        return;
    }
    
    numberOfRuns++;
}


@end
