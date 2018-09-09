//
//  CONGameStateController.m
//  concentration
//
//  Created by David Attaie on 9/9/18.
//  Copyright © 2018 David Attaie. All rights reserved.
//

#import "CONGameStateController.h"
#import "CONScore.h"

@interface CONGameStateController()

@property (nonatomic, nullable, strong, readwrite) NSArray<CONScore *> *topScores;

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

- (void)saveScore:(NSInteger)score withCardCount:(NSInteger)count {
    NSMutableArray<CONScore *> *scoreArray = [[self topScores] mutableCopy];
    CONScore *parsedScore = [[CONScore alloc] initWithScore:score numberOfPairs:count];
    [scoreArray addObject:parsedScore];
    
    [scoreArray sortUsingComparator:^NSComparisonResult(CONScore *_Nonnull obj1, CONScore *_Nonnull obj2) {
        return obj1.score > obj2.score;
    }];
    
    [self setTopScores:[scoreArray copy]];
}

#pragma mark - Top Score Persistence

- (NSArray<CONScore *> *)topScores {
    if (!_topScores) {
        NSData *dataForKey = [[NSUserDefaults standardUserDefaults] objectForKey:TopScoresKey];
        NSArray<CONScore *> *existingValue = [NSKeyedUnarchiver unarchiveObjectWithData:dataForKey];
        _topScores = existingValue ?: [NSArray<CONScore *> new];
    }
    return _topScores;
}

- (void)setTopScores:(NSArray<CONScore *> *)topScores {
    _topScores = topScores;
    
    NSData *encodedScore = [NSKeyedArchiver archivedDataWithRootObject:topScores];
    [[NSUserDefaults standardUserDefaults] setObject:encodedScore forKey:TopScoresKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


@end
