//
//  CONGameViewController.m
//  concentration
//
//  Created by David Attaie on 9/8/18.
//  Copyright © 2018 David Attaie. All rights reserved.
//

#import "CONCardCollectionViewCell.h"
#import "CONGameViewController.h"
#import "UIColor+Random.h"
#import "CONCard.h"

@interface CONGameViewController () <UICollectionViewDataSource>

@property (nonatomic, nullable, strong) NSArray<CONCard *> *arrayOfCards;
@property (nonatomic, nullable, weak) UICollectionView *collectionView;
@property (nonatomic, assign) NSInteger numberOfPairs;

@end

@implementation CONGameViewController

- (instancetype)initWithSize:(NSInteger)size {
    if (self = [super init]) {
        _numberOfPairs = size;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor greenColor]];
    [self setupCards];
    [self setupCollectionView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)setupCollectionView {
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:[self.view frame] collectionViewLayout:flowLayout];
    [collectionView setDataSource:self];
    [collectionView registerClass:[CONCardCollectionViewCell class] forCellWithReuseIdentifier:[CONCardCollectionViewCell cellIdentifier]];
    [self.view addSubview:collectionView];
    [self setupConstraintsForCollectionView:collectionView];
}

- (void)setupConstraintsForCollectionView:(UICollectionView *)collectionView {
    [collectionView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [[collectionView.leadingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.leadingAnchor] setActive:YES];
    [[collectionView.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor] setActive:YES];
    [[collectionView.bottomAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.bottomAnchor] setActive:YES];
    [[collectionView.trailingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.trailingAnchor] setActive:YES];
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

@end
