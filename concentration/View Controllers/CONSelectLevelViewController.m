//
//  CONSelectLevelViewController.m
//  concentration
//
//  Created by David Attaie on 9/8/18.
//  Copyright © 2018 David Attaie. All rights reserved.
//

#import "CONSelectLevelViewController.h"

@interface CONSelectLevelViewController () <UIPickerViewDataSource, UIPickerViewDelegate>

@property (nonatomic, nullable, weak) UILabel *titleLabel;
@property (nonatomic, nullable, weak) UIPickerView *pickerView;
@property (nonatomic, nullable, weak) UIButton *nextButton;

@end

@implementation CONSelectLevelViewController

const NSInteger MaximumDifficulty = 100;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTitleLabel];
    [self setupPickerView];
    [self setupNextButton];
}

#pragma mark - Configure and Setup Views

- (void)setupTitleLabel {
    UILabel *titleLabel = [UILabel new];
    [titleLabel setText:@"Select Difficulty"];
    [titleLabel setTextAlignment:NSTextAlignmentCenter];
    [self.view addSubview:titleLabel];
    self.titleLabel = titleLabel;
    [self addConstraintsForTitleLabel:titleLabel];
}

- (void)addConstraintsForTitleLabel:(UILabel *)titleLabel {
    [titleLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [[titleLabel.topAnchor constraintEqualToAnchor:self.view.topAnchor constant:8.0f] setActive:YES];
    [[titleLabel.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor] setActive:YES];
    [[titleLabel.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor] setActive:YES];
    [[titleLabel.heightAnchor constraintEqualToConstant:24.0f] setActive:YES];
}

- (void)setupPickerView {
    UIPickerView *pickerView = [UIPickerView new];
    [pickerView setDelegate:self];
    [pickerView setDataSource:self];
    [pickerView selectRow:4 inComponent:0 animated:NO];
    [self.view addSubview:pickerView];
    self.pickerView = pickerView;
    [self addConstraintsForPickerView:pickerView];
}

- (void)addConstraintsForPickerView:(UIPickerView *)pickerView {
    [pickerView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [[pickerView.topAnchor constraintEqualToAnchor:self.titleLabel.bottomAnchor constant:8.0f] setActive:YES];
    [[pickerView.leadingAnchor constraintEqualToAnchor:self.titleLabel.leadingAnchor] setActive:YES];
    [[pickerView.trailingAnchor constraintEqualToAnchor:self.titleLabel.trailingAnchor] setActive:YES];
}

- (void)setupNextButton {
    UIButton *nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [nextButton setTitle:@"Select" forState:UIControlStateNormal];
    [nextButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [nextButton addTarget:self action:@selector(selectedNext:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nextButton];
    self.nextButton = nextButton;
    [self addConstraintsForNextButton:nextButton];
}

- (void)addConstraintsForNextButton:(UIButton *)nextButton {
    [nextButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [[nextButton.topAnchor constraintEqualToAnchor:self.pickerView.bottomAnchor constant:8.0f] setActive:YES];
    [[nextButton.leadingAnchor constraintEqualToAnchor:self.titleLabel.leadingAnchor] setActive:YES];
    [[nextButton.trailingAnchor constraintEqualToAnchor:self.titleLabel.trailingAnchor] setActive:YES];
    [[nextButton.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor constant:-8.0f] setActive:YES];
    [[nextButton.heightAnchor constraintEqualToConstant:24.0f] setActive:YES];
}

- (void)selectedNext:(id)sender {
    if ([self.delegate respondsToSelector:@selector(didSelectLevel:)]) {
        NSInteger selectedLevel = [self.pickerView selectedRowInComponent:0] + 1; //dont allow levels of size 0
        [self.delegate didSelectLevel:selectedLevel];
    }
}

#pragma mark - Picker View Data Source AND Delegate

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
