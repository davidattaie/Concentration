//
//  CONPreviousScoreViewController.m
//  concentration
//
//  Created by David Attaie on 9/8/18.
//  Copyright © 2018 David Attaie. All rights reserved.
//

#import "CONPreviousScoreViewController.h"
#import "CONScoreTableViewCell.h"

@interface CONPreviousScoreViewController () <UITableViewDataSource>

@property (nonatomic, nullable, weak) UITableView *tableView;
@property (nonatomic, nullable, weak) UIButton *backButton;

@end

@implementation CONPreviousScoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTableView];
}

- (void)setupTableView {
    UITableView *tableView = [UITableView new];
    [tableView setDataSource:self];
    [self.view addSubview:tableView];
    self.tableView = tableView;
    [self addConstraintsForTableView:tableView];
}

- (void)addConstraintsForTableView:(UITableView *)tableView {
    [tableView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [[tableView.leadingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.leadingAnchor] setActive:YES];
    [[tableView.trailingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.trailingAnchor] setActive:YES];
    [[tableView.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor] setActive:YES];
    [[tableView.bottomAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.bottomAnchor] setActive:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CONScoreTableViewCell *scoreCell = [tableView dequeueReusableCellWithIdentifier:[CONScoreTableViewCell cellIdentifier]];
    
    return scoreCell;
}

@end
