//
//  CONGameViewController.m
//  concentration
//
//  Created by David Attaie on 9/8/18.
//  Copyright © 2018 David Attaie. All rights reserved.
//

#import "CONCardCollectionViewCell.h"
#import "CONGameStateController.h"
#import "CONGameViewController.h"
#import "UIColor+Random.h"
#import "CONCard.h"

@interface CONGameViewController () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, nullable, strong) NSArray<CONCard *> *arrayOfCards;
@property (nonatomic, nullable, weak) UICollectionView *collectionView;
@property (nonatomic, nullable, weak) UIButton *endGameButton;
@property (nonatomic, nullable, weak) UILabel *scoreLabel;
@property (nonatomic, assign) NSInteger numberOfPairs;
@property (nonatomic, assign) NSInteger score;

@end

@implementation CONGameViewController

static CGFloat DeselectingTime = 0.2f;  //Amount of time the user gets to see their selection for

- (instancetype)initWithSize:(NSInteger)size {
    if (self = [super init]) {
        _numberOfPairs = size;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupGame];
    [self setupScoreLabel];
    [self setupEndGameButton];
    [self setupCollectionView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)setupGame {
    [self setupCards];
    [self setScore:0];
}

- (void)setScore:(NSInteger)score {
    _score = score;
    [self updateScore];
}

- (void)setupCollectionView {
    UICollectionViewFlowLayout *flowLayout = [UICollectionViewFlowLayout new];
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:[self.view frame] collectionViewLayout:flowLayout];
    [collectionView setDataSource:self];
    [collectionView setDelegate:self];
    [collectionView setAllowsMultipleSelection:YES];
    [collectionView registerClass:[CONCardCollectionViewCell class] forCellWithReuseIdentifier:[CONCardCollectionViewCell cellIdentifier]];
    [self.view addSubview:collectionView];
    self.collectionView = collectionView;
    [self setupConstraintsForCollectionView:collectionView];
}

- (void)setupConstraintsForCollectionView:(UICollectionView *)collectionView {
    [collectionView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [[collectionView.topAnchor constraintEqualToAnchor:self.scoreLabel.bottomAnchor] setActive:YES];
    [[collectionView.bottomAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.bottomAnchor] setActive:YES];
    [[collectionView.trailingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.trailingAnchor] setActive:YES];
    [[collectionView.leadingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.leadingAnchor] setActive:YES];
}

- (void)setupScoreLabel {
    UILabel *scoreLabel = [UILabel new];
    [scoreLabel setTextAlignment:NSTextAlignmentRight];
    [scoreLabel setTextColor:[UIColor whiteColor]];
    [self.view addSubview:scoreLabel];
    [self setupConstraintsForScoreLabel:scoreLabel];
    self.scoreLabel = scoreLabel;
    [self updateScore];
}

- (void)setupConstraintsForScoreLabel:(UILabel *)label {
    [label setTranslatesAutoresizingMaskIntoConstraints:NO];
    [[label.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor] setActive:YES];
    [[label.heightAnchor constraintEqualToConstant:24.0f] setActive:YES];
    [[label.trailingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.trailingAnchor constant:-24.0f] setActive:YES];
}

- (void)setupEndGameButton {
    UIButton *endGameButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [endGameButton setTitle:@"End Game" forState:UIControlStateNormal];
    [endGameButton addTarget:self action:@selector(endGame:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:endGameButton];
    [self setupConstraintsForEndGameButton:endGameButton];
}

- (void)setupConstraintsForEndGameButton:(UIButton *)button {
    [button setTranslatesAutoresizingMaskIntoConstraints:NO];
    [[button.trailingAnchor constraintEqualToAnchor:self.scoreLabel.leadingAnchor] setActive:YES];
    [[button.leadingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.leadingAnchor constant:24.0f] setActive:YES];
    [[button.heightAnchor constraintEqualToAnchor:self.scoreLabel.heightAnchor multiplier:1.0f] setActive:YES];
    [[button.centerYAnchor constraintEqualToAnchor:self.scoreLabel.centerYAnchor] setActive:YES];
}

#pragma mark - Check Game State And Configure Score

- (void)checkGameStatus {
    for (CONCard *card in self.arrayOfCards) {
        if (!card.isRevealed) {
            return;
        }
    }
    [[CONGameStateController sharedController] saveScore:self.score];
    [self showFinalScore];
}

- (void)updateScore {
    NSString *scoreString = [NSString stringWithFormat:@"Score: %li", self.score];
    [self.scoreLabel setText:scoreString];
}

#pragma mark - Actions

- (void)endGame:(id)target {
    //notification to save state?
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)showFinalScore {
    NSString *message = [NSString stringWithFormat:@"Good Job!\n\nYour score was %li\nWould you like to start a new game?", self.score];
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Congratulations!" message:message preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"New Game" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self setupGame];
        [self.collectionView reloadData];
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"Main Menu" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }]];
    [self presentViewController:alertController animated:YES completion:nil];
}

#pragma mark - Setup and Configure Cards

- (void)setupCards {
    NSMutableSet<CONCard *> *cardsSet = [NSMutableSet<CONCard *> new];
    for (int i = 0; i < self.numberOfPairs; i++) {
        CONCard *card = [[CONCard alloc] initWithColor:[UIColor randomColor] andValue:i];
        [cardsSet addObject:card];
        [cardsSet addObject:[card copy]];
    }

    [self setArrayOfCards:[cardsSet allObjects]];
}

#pragma mark - Collection View Data Source

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self arrayOfCards].count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CONCardCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[CONCardCollectionViewCell cellIdentifier] forIndexPath:indexPath];
    CONCard *card = self.arrayOfCards[indexPath.row];
    [cell setupWithCard:card];
    return cell;
}

#pragma mark - Collection View Delegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    CONCard *selectedCard = self.arrayOfCards[indexPath.row];
    CONCardCollectionViewCell *selectedCell = (CONCardCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    [selectedCell setupWithCard:selectedCard];
    
    self.score++;
    
    if (collectionView.indexPathsForSelectedItems.count > 1) {
        [collectionView setUserInteractionEnabled:NO];
        __weak typeof(self) weakSelf = self;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(DeselectingTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            for (NSIndexPath *path in collectionView.indexPathsForSelectedItems) {
                CONCardCollectionViewCell *cell = (CONCardCollectionViewCell *)[collectionView cellForItemAtIndexPath:path];
                CONCard *card = self.arrayOfCards[path.row];
                [collectionView deselectItemAtIndexPath:path animated:NO];
                [cell setupWithCard:card];
                
                if (path != indexPath && card.value == selectedCard.value) {
                    [selectedCard setIsRevealed:YES];
                    [card setIsRevealed:YES];
                    [cell setupWithCard:card];
                    [selectedCell setupWithCard:selectedCard];
                }
            }
            [collectionView setUserInteractionEnabled:YES];
            [weakSelf checkGameStatus];
        });
    }
}

@end
