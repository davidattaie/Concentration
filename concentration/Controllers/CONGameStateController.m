//
//  CONGameStateController.m
//  concentration
//
//  Created by David Attaie on 9/9/18.
//  Copyright © 2018 David Attaie. All rights reserved.
//
@import UIKit;

#import "CONGameStateController.h"
#import "CONGameState.h"
#import "CONScore.h"

@interface CONGameStateController()

@property (nonatomic, nullable, strong, readwrite) NSArray<CONScore *> *topScores;

@end

@implementation CONGameStateController

@synthesize topScores = _topScores;

NSString * const TopScoresKey = @"kCONTopScoresKey";
NSString * const GameStateKey = @"kCONGameStateKey";

+ (CONGameStateController *)sharedController {
    static CONGameStateController *controller = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        controller = [CONGameStateController new];
    });
    return controller;
}

- (instancetype)init {
    if (self = [super init]) {
        [self registerForNotifications];
    }
    return self;
}

- (void)setCurrentGameState:(CONGameState *)currentGameState {
    _currentGameState = currentGameState;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)registerForNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didMoveToBackground:) name:UIApplicationDidEnterBackgroundNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(willEnterForeground:) name:UIApplicationWillEnterForegroundNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(willTerminate:) name:UIApplicationWillTerminateNotification object:nil];
}

- (void)saveScore:(CONScore *)score {
    NSMutableArray<CONScore *> *scoreArray = [[self topScores] mutableCopy];
    [scoreArray addObject:score];
    
    [scoreArray sortUsingComparator:^NSComparisonResult(CONScore *_Nonnull obj1, CONScore *_Nonnull obj2) {
        return obj1.score > obj2.score;
    }];
    
    [self setTopScores:[scoreArray copy]];
}

#pragma mark - Notifications

- (void)didMoveToBackground:(NSNotification *)note {
    [self saveCurrentGameState];
}

- (void)willEnterForeground:(NSNotification *)note {
    [self restoreCurrentGameState];
}

- (void)willTerminate:(NSNotification *)note {
    [self saveCurrentGameState];
}

#pragma mark - Game State Persistence

- (void)saveCurrentGameState {
    NSData *encodedState = [NSKeyedArchiver archivedDataWithRootObject:self.currentGameState];
    [[NSUserDefaults standardUserDefaults] setObject:encodedState forKey:GameStateKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)clearLastSavedGameState {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:GameStateKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)restoreCurrentGameState {
    NSData *dataForKey = [[NSUserDefaults standardUserDefaults] objectForKey:GameStateKey];
    CONGameState *existingValue = [NSKeyedUnarchiver unarchiveObjectWithData:dataForKey];
    _currentGameState = existingValue;
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

#pragma mark - Game State Management

- (void)createNewGameStateWithDifficulty:(NSInteger)difficulty {
    CONGameState *newGameState = [[CONGameState alloc] initNewGameWithDifficulty:difficulty];
    self.currentGameState = newGameState;
}



@end
