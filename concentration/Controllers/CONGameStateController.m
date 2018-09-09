//
//  CONGameStateController.m
//  concentration
//
//  Created by David Attaie on 9/9/18.
//  Copyright © 2018 David Attaie. All rights reserved.
//

#import "CONGameStateController.h"

@interface CONGameStateController()

@property (nonatomic, nullable, strong, readwrite) NSArray<NSNumber *> *topScores;

@end

@implementation CONGameStateController

@synthesize topScores = _topScores;

static NSString *TopScoresKey = @"kCONTopScoresKey";

+ (CONGameStateController *)sharedController {
    static CONGameStateController *controller = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        controller = [CONGameStateController new];
    });
    return controller;
}

- (void)saveScore:(NSInteger)score {
    NSMutableArray<NSNumber *> *scoreArray = [[self topScores] mutableCopy];
    [scoreArray addObject:@(score)];
    
    [scoreArray sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return obj1 > obj2;
    }];
    
    [self setTopScores:[scoreArray copy]];
}

#pragma mark - Top Score Persistence

- (NSArray<NSNumber *> *)topScores {
    if (!_topScores) {
        NSArray<NSNumber *> *existingValue = [[NSUserDefaults standardUserDefaults] arrayForKey:TopScoresKey];
        _topScores = existingValue ?: @[];
    }
    return _topScores;
}

- (void)setTopScores:(NSArray<NSNumber *> *)topScores {
    _topScores = topScores;
    [[NSUserDefaults standardUserDefaults] setObject:topScores forKey:TopScoresKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


@end
