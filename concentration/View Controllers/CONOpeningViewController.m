//
//  CONOpeningViewController.m
//  concentration
//
//  Created by David Attaie on 9/8/18.
//  Copyright © 2018 David Attaie. All rights reserved.
//

#import "CONOpeningViewController.h"
#import "CONGameViewController.h"

@interface CONOpeningViewController ()

@end

@implementation CONOpeningViewController

static CGFloat buttonHeight = 80.0f;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor redColor]];
    [self setupButtonStack];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (NSArray<UIView *> *)buttons {
    UIButton *newGameButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [newGameButton setTitle:@"New Game" forState:UIControlStateNormal];
    [newGameButton addTarget:self action:@selector(launchNewGame:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *previousScoresButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [previousScoresButton setTitle:@"Previous Scores" forState:UIControlStateNormal];
    
    return @[newGameButton, previousScoresButton];
}

- (void)setupButtonStack {
    NSArray *buttons = [self buttons];
    UIStackView *buttonStack = [[UIStackView alloc] initWithArrangedSubviews:buttons];
    [buttonStack setAlignment:UIStackViewAlignmentCenter];
    [buttonStack setDistribution:UIStackViewDistributionFillEqually];
    [buttonStack setAxis:UILayoutConstraintAxisVertical];
    [self.view addSubview:buttonStack];
    [self setupConstraintsForButtonStack:buttonStack withNumberOfButtons:buttons.count];
}

- (void)setupConstraintsForButtonStack:(UIStackView *)buttonStack withNumberOfButtons:(NSInteger)numberOfButtons {
    [[buttonStack.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor] setActive:YES];
    [buttonStack setTranslatesAutoresizingMaskIntoConstraints:NO];
    [[buttonStack.heightAnchor constraintEqualToConstant:numberOfButtons * buttonHeight] setActive:YES];
    [[buttonStack.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor] setActive:YES];
    [[buttonStack.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor] setActive:YES];
    [self.view layoutIfNeeded];
}

#pragma mark - Button Actions

- (void)launchNewGame:(id)target {
    CONGameViewController *gameViewController = [CONGameViewController new];
    [self presentViewController:gameViewController animated:YES completion:nil];
}

@end
