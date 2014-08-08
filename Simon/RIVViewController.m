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

@interface RIVViewController () <UIGestureRecognizerDelegate, RIVColorViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *highestLevelAchievedLable;

@property (strong, nonatomic) RIVGameBoard *gameboard;
@property (strong, nonatomic) RIVColorView *redView;
@property (strong, nonatomic) RIVColorView *greenView;
@property (strong, nonatomic) UIView *blueView;
@property (strong, nonatomic) UIView *yellowView;
@property (strong, nonatomic) UIView *magentaView;
@property (strong, nonatomic) UIView *cyanView;

@end

@implementation RIVViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"highestLevelCompleted"];
    self.highestLevelAchievedLable.text = [NSString stringWithFormat:@"Highest Level Achieved: %d", self.gameboard.highestLevelCompleted];
    [self setupColorViews];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)setupColorViews
{
    self.redView = [[RIVColorView alloc] initWithHighlightedColor:[UIColor highlightedRed]
                                               unhighlightedColor:[UIColor unhighlightedRed]
                                                            frame:CGRectMake(20, 118, 130, 130)];
    self.redView.tag = 10;
    self.redView.delegate = self;
    [self.view addSubview:self.redView];
    
    self.greenView = [[RIVColorView alloc] initWithHighlightedColor:[UIColor highlightedGreen]
                                                 unhighlightedColor:[UIColor unhighlightedGreen]
                                                              frame:CGRectMake(170, 118, 130, 130)];
    self.greenView.tag = 20;
    self.greenView.delegate = self;
    [self.view addSubview:self.greenView];
    
    
//    self.redView = [[UIView alloc] initWithFrame:CGRectMake(20, 118, 130, 130)];
//    self.greenView = [[UIView alloc] initWithFrame:CGRectMake(170, 118, 130, 130)];
    self.blueView = [[UIView alloc] initWithFrame:CGRectMake(20, 268, 130, 130)];
    self.yellowView = [[UIView alloc] initWithFrame:CGRectMake(170, 268, 130, 130)];
    self.magentaView = [[UIView alloc] initWithFrame:CGRectMake(20, 418, 130, 130)];
    self.cyanView = [[UIView alloc] initWithFrame:CGRectMake(170, 418, 130, 130)];
    
//    [self setupColorView:self.redView withColor:[UIColor unhighlightedRed]];
//    [self setupColorView:self.greenView withColor:[UIColor unhighlightedGreen]];
    [self setupColorView:self.blueView withColor:[UIColor unhighlightedBlue]];
    [self setupColorView:self.yellowView withColor:[UIColor unhighlightedYellow]];
    [self setupColorView:self.magentaView withColor:[UIColor unhighlightedMagenta]];
    [self setupColorView:self.cyanView withColor:[UIColor unhighlightedCyan]];
    
}

- (void)touchUpEventOnView:(RIVColorView *)view
{
    NSLog(@"touched view with tag: %d", view.tag);
}

- (void)setupColorView:(UIView *)view withColor:(UIColor *)color
{
    view.backgroundColor = color;
    [self.view addSubview:view];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(testColorPlayed:)];
    tapGesture.delegate = self;
    [view addGestureRecognizer:tapGesture];
    
    UILongPressGestureRecognizer *longPressedGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(testColorPressed:)];
    longPressedGesture.minimumPressDuration = 0.001;
    longPressedGesture.delegate = self;
    [view addGestureRecognizer:longPressedGesture];
}

- (void)testColorPressed:(UIGestureRecognizer *)longPressedGesture
{
    if (longPressedGesture.state == UIGestureRecognizerStateBegan) {
        NSLog(@"%@", [longPressedGesture.class description]);
        
        if ([longPressedGesture.view isEqual:self.redView]) {
            self.redView.backgroundColor = [UIColor highlightedRed];
        } else if ([longPressedGesture.view isEqual:self.greenView]) {
            self.greenView.backgroundColor = [UIColor highlightedGreen];
        } else if ([longPressedGesture.view isEqual:self.blueView]) {
            self.blueView.backgroundColor = [UIColor highlightedBlue];
        } else if ([longPressedGesture.view isEqual:self.yellowView]) {
            self.yellowView.backgroundColor = [UIColor highlightedYellow];
        } else if ([longPressedGesture.view isEqual:self.magentaView]) {
            self.magentaView.backgroundColor = [UIColor highlightedMagenta];
        } else if ([longPressedGesture.view isEqual:self.cyanView]) {
            self.cyanView.backgroundColor = [UIColor highlightedCyan];
        }
    }
}

- (void)testColorPlayed:(UIGestureRecognizer *)tapGesture
{
    NSLog(@"%@", [tapGesture.class description]);
    
    if ([tapGesture.view isEqual:self.redView]) {
        self.redView.backgroundColor = [UIColor unhighlightedRed];
    } else if ([tapGesture.view isEqual:self.greenView]) {
        self.greenView.backgroundColor = [UIColor unhighlightedGreen];
    } else if ([tapGesture.view isEqual:self.blueView]) {
        self.blueView.backgroundColor = [UIColor unhighlightedBlue];
    } else if ([tapGesture.view isEqual:self.yellowView]) {
        self.yellowView.backgroundColor = [UIColor unhighlightedYellow];
    } else if ([tapGesture.view isEqual:self.magentaView]) {
        self.magentaView.backgroundColor = [UIColor unhighlightedMagenta];
    } else if ([tapGesture.view isEqual:self.cyanView]) {
        self.cyanView.backgroundColor = [UIColor unhighlightedCyan];
    }
}


#pragma mark - UIGestureRecognizer Delegate


- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
//    NSLog(@"should begin: %@", gestureRecognizer.description);
    return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
//    NSLog(@"with: %@, other: %@", [gestureRecognizer.class description], [otherGestureRecognizer.class description]);
    return YES;
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
    
    sender.backgroundColor = [UIColor colorWithRed:newRed green:newGreen blue:newBlue alpha:1.0];
}

- (IBAction)colorReleased:(UIButton *)sender
{
    const CGFloat *components = CGColorGetComponents(sender.backgroundColor.CGColor);
    float newRed = (components[0] > 0.5) ? 0.784 : 0.0;
    float newGreen = (components[1] > 0.5) ? 0.784 : 0.0;
    float newBlue = (components[2] > 0.5) ? 0.784 : 0.0;
    
    sender.backgroundColor = [UIColor colorWithRed:newRed green:newGreen blue:newBlue alpha:1.0];
    
    RIVGameBoardPlayOutcome outcome = [self.gameboard playColor:sender.tag];
    [self reflectOutcome:outcome];
}

- (void)reflectOutcome:(RIVGameBoardPlayOutcome)outcome
{
    switch (outcome) {
        case RIVGameBoardPlayOutcomeIncorrect:
//            [self.gameboard newGame];
            break;
        case RIVGameBoardPlayOutcomeCorrect:
            break;
        case RIVGameBoardPlayOutcomeLevelComplete:
            self.highestLevelAchievedLable.text = [NSString stringWithFormat:@"Highest Level Achieved: %d", self.gameboard.highestLevelCompleted];
            NSLog(@"%@", self.gameboard.colorSequence.description);
            break;
        case RIVGameBoardPlayOutcomeNotPlayable:
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
