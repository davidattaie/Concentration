//
//  CONOpeningViewController.m
//  concentration
//
//  Created by David Attaie on 9/8/18.
//  Copyright © 2018 David Attaie. All rights reserved.
//

#import "CONSelectLevelViewController.h"
#import "CONOpeningViewController.h"
#import "CONGameViewController.h"

@interface CONOpeningViewController () <CONSelectLevelDelegate>

@property (nonatomic, nullable, weak) CONSelectLevelViewController *selectLevelController;

@end

@implementation CONOpeningViewController

static CGFloat ButtonHeight = 80.0f;

- (void)viewDidLoad {
    [super viewDidLoad];
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
    [[buttonStack.heightAnchor constraintEqualToConstant:numberOfButtons * ButtonHeight] setActive:YES];
    [[buttonStack.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor] setActive:YES];
    [[buttonStack.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor] setActive:YES];
    [self.view layoutIfNeeded];
}

#pragma mark - Button Actions
    
- (void)launchNewGame:(id)target {
    CONSelectLevelViewController *selectLevelController = [[CONSelectLevelViewController alloc] init];
    [selectLevelController.view setBackgroundColor:[UIColor whiteColor]];
    [selectLevelController setDelegate:self];
    [self addChildViewController:selectLevelController];
    [self.view addSubview:selectLevelController.view];
    self.selectLevelController = selectLevelController;
    [self setupConstraintsForSelectLevelController:selectLevelController.view];
}

- (void)setupConstraintsForSelectLevelController:(UIView *)selectLevelView {
    [selectLevelView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [[selectLevelView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor constant:-16.0f] setActive:YES];
    [[selectLevelView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:16.0f] setActive:YES];
    [[selectLevelView.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor] setActive:YES];
    [[selectLevelView.heightAnchor constraintEqualToConstant:240.0f] setActive:YES];
}

- (void)didSelectLevel:(NSInteger)level {
    CONGameViewController *gameViewController = [[CONGameViewController alloc] initWithSize:level];
    [self presentViewController:gameViewController animated:YES completion:^{
        [self.selectLevelController removeFromParentViewController];
        [self.selectLevelController.view removeFromSuperview];
        self.selectLevelController = nil;
    }];
}

@end
