//
//  CONLoadingButton.m
//  concentration
//
//  Created by David Attaie on 9/9/18.
//  Copyright © 2018 David Attaie. All rights reserved.
//

#import "CONLoadingButton.h"

@interface CONLoadingButton()

@property (nonatomic, nullable, weak) UIActivityIndicatorView *spinner;

@end

@implementation CONLoadingButton

- (UIActivityIndicatorView *)spinner {
    if (!_spinner) {
        UIActivityIndicatorView *spinner = [UIActivityIndicatorView new];
        [spinner setHidesWhenStopped:YES];
        [self addSubview:spinner];
        _spinner = spinner;
        [self addConstraintsForSpinner:spinner];
    }
    return _spinner;
}

- (void)addConstraintsForSpinner:(UIActivityIndicatorView *)spinner {
    [spinner setTranslatesAutoresizingMaskIntoConstraints:NO];
    [[spinner.centerXAnchor constraintEqualToAnchor:self.centerXAnchor] setActive:YES];
    [[spinner.centerYAnchor constraintEqualToAnchor:self.centerYAnchor] setActive:YES];
}

- (void)startLoading {
    [self setTitleColor:[UIColor colorWithWhite:1.0f alpha:0.1f] forState:UIControlStateDisabled];
    [self.spinner startAnimating];
}

- (void)stopLoading {
    [self setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
    [self.spinner stopAnimating];
}

@end
