//
//  CONOpeningViewController.m
//  concentration
//
//  Created by David Attaie on 9/8/18.
//  Copyright © 2018 David Attaie. All rights reserved.
//

#import "CONPreviousScoreViewController.h"
#import "CONSelectLevelViewController.h"
#import "CONMainMenuViewController.h"
#import "CONGameStateController.h"
#import "CONGameViewController.h"
#import "CONLoadingButton.h"
#import "CONGameState.h"

@interface CONMainMenuViewController () <CONSelectLevelDelegate>

@property (nonatomic, nullable, weak) CONSelectLevelViewController *selectLevelController;
@property (nonatomic, nullable, weak) CONLoadingButton *resumeGameButton;

@end

@implementation CONMainMenuViewController

static CGFloat ButtonHeight = 80.0f;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupButtonStack];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self loadAndUpdateResumeStatus];
}

- (void)loadAndUpdateResumeStatus {
    __weak typeof(self) weakSelf = self;
    [self.resumeGameButton setEnabled:NO];
    [self.resumeGameButton startLoading];
    [[CONGameStateController sharedController] restoreCurrentGameState:CONSaveGameLocationAll withCompletion:^{
        if ([[CONGameStateController sharedController] currentGameState]) {
            [weakSelf.resumeGameButton setEnabled:YES];
            [weakSelf.resumeGameButton setTitle:@"Resume Last Saved Game" forState:UIControlStateNormal];
        } else {
            [weakSelf.resumeGameButton setEnabled:NO];
            [weakSelf.resumeGameButton setTitle:@"No Saved Game Found" forState:UIControlStateNormal];
        }
        [weakSelf.resumeGameButton stopLoading];
    }];
}

- (NSArray<UIView *> *)buttons {
    UIButton *newGameButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [newGameButton setTitle:@"New Game" forState:UIControlStateNormal];
    [newGameButton addTarget:self action:@selector(launchNewGame:) forControlEvents:UIControlEventTouchUpInside];
    
    CONLoadingButton *resumeLastGame = [CONLoadingButton buttonWithType:UIButtonTypeCustom];
    [resumeLastGame setTitle:@"Loading Last Saved Game.." forState:UIControlStateNormal];
    [resumeLastGame addTarget:self action:@selector(launchLastSavedGame:) forControlEvents:UIControlEventTouchUpInside];
    self.resumeGameButton = resumeLastGame;
    
    UIButton *previousScoresButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [previousScoresButton setTitle:@"Previous Scores" forState:UIControlStateNormal];
    [previousScoresButton addTarget:self action:@selector(showPreviousScores:) forControlEvents:UIControlEventTouchUpInside];
    
    return @[newGameButton, resumeLastGame, previousScoresButton];
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
    
- (void)launchNewGame:(id)sender {
    CONSelectLevelViewController *selectLevelController = [[CONSelectLevelViewController alloc] init];
    [selectLevelController.view setBackgroundColor:[UIColor whiteColor]];
    [selectLevelController setDelegate:self];
    [self addChildViewController:selectLevelController];
    [self.view addSubview:selectLevelController.view];
    self.selectLevelController = selectLevelController;
    [self setupConstraintsForSelectLevelController:selectLevelController.view];
}

- (void)showPreviousScores:(id)sender {
    CONPreviousScoreViewController *previousScoreViewController = [CONPreviousScoreViewController new];
    [self.navigationController pushViewController:previousScoreViewController animated:YES];
}

- (void)launchLastSavedGame:(id)sender {
    CONGameState *currentGame = [[CONGameStateController sharedController] currentGameState];
    CONGameViewController *gameViewController = [[CONGameViewController alloc] initWithGameState:currentGame];
    [self presentViewController:gameViewController animated:YES completion:nil];
}

- (void)setupConstraintsForSelectLevelController:(UIView *)selectLevelView {
    [selectLevelView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [[selectLevelView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor constant:-16.0f] setActive:YES];
    [[selectLevelView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:16.0f] setActive:YES];
    [[selectLevelView.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor] setActive:YES];
    [[selectLevelView.heightAnchor constraintEqualToConstant:240.0f] setActive:YES];
}

- (void)didSelectLevel:(NSInteger)level {
    [self.selectLevelController removeFromParentViewController];
    [self.selectLevelController.view removeFromSuperview];
    self.selectLevelController = nil;
    
    CONGameState *gameState = [[CONGameState alloc] initNewGameWithDifficulty:level];
    CONGameViewController *gameViewController = [[CONGameViewController alloc] initWithGameState:gameState];
    [self presentViewController:gameViewController animated:YES completion:nil];
}

@end
