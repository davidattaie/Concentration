//
//  CONOpeningViewController.m
//  concentration
//
//  Created by David Attaie on 9/8/18.
//  Copyright © 2018 David Attaie. All rights reserved.
//

#import "CONOpeningViewController.h"
#import "CONGameViewController.h"

@interface CONOpeningViewController () <UIPickerViewDataSource, UIPickerViewDelegate>

@end

@implementation CONOpeningViewController

static CGFloat ButtonHeight = 80.0f;
static NSInteger MaximumDifficulty = 1024;

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
    [[buttonStack.heightAnchor constraintEqualToConstant:numberOfButtons * ButtonHeight] setActive:YES];
    [[buttonStack.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor] setActive:YES];
    [[buttonStack.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor] setActive:YES];
    [self.view layoutIfNeeded];
}

#pragma mark - Button Actions

- (void)launchNewGame:(id)target {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Select Difficulty"
                                                                             message:@"\n\n\n\n\n\n\n" preferredStyle:UIAlertControllerStyleAlert];
    UIPickerView *pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(5.0f, 20.0f, 250.0f, 140.0f)];
    [pickerView setDataSource:self];
    [pickerView setDelegate:self];
    [pickerView selectRow:4 inComponent:0 animated:NO];
    [alertController.view addSubview:pickerView];

    [alertController addAction:[UIAlertAction actionWithTitle:@"Select Difficulty" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self dismissViewControllerAnimated:YES completion:nil];
        NSInteger selectedLevel = [pickerView selectedRowInComponent:0] + 1; //dont allow levels of size 0
        CONGameViewController *gameViewController = [[CONGameViewController alloc] initWithSize:selectedLevel];
        [self presentViewController:gameViewController animated:YES completion:nil];
    }]];
    
    [self presentViewController:alertController animated:YES completion:nil];
    
}

#pragma mark - Picker View Data Source

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [NSString stringWithFormat:@"%li", row + 1];
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return MaximumDifficulty;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

@end
