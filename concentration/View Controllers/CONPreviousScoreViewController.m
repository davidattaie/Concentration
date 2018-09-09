//
//  CONPreviousScoreViewController.m
//  concentration
//
//  Created by David Attaie on 9/8/18.
//  Copyright © 2018 David Attaie. All rights reserved.
//

#import "CONPreviousScoreViewController.h"
#import "CONGameStateController.h"
#import "CONScoreTableViewCell.h"
#import "CONScore.h"

@interface CONPreviousScoreViewController () <UITableViewDataSource>

@property (nonatomic, nullable, weak) UITableView *tableView;
@property (nonatomic, nullable, weak) UIButton *backButton;

@end

@implementation CONPreviousScoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"Top Scores"];
    [self setupTableView];
}

#pragma mark - Configure and Setup Views

- (void)setupTableView {
    UITableView *tableView = [UITableView new];
    [tableView setDataSource:self];
    [tableView registerClass:[CONScoreTableViewCell class] forCellReuseIdentifier:[CONScoreTableViewCell cellIdentifier]];
    [tableView setTableFooterView:[UIView new]];
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

#pragma mark - Table View Data Source Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[CONGameStateController sharedController] topScores].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CONScoreTableViewCell *scoreCell = [tableView dequeueReusableCellWithIdentifier:[CONScoreTableViewCell cellIdentifier]];
    CONScore *score = [[CONGameStateController sharedController] topScores][indexPath.row];
    [scoreCell setupWithScore:score];
    return scoreCell;
}

@end
