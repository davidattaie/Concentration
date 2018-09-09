//
//  CONGameState.m
//  concentration
//
//  Created by David Attaie on 9/9/18.
//  Copyright © 2018 David Attaie. All rights reserved.
//

#import "UIColor+Random.h"
#import "CONGameState.h"
#import "CONScore.h"
#import "CONCard.h"

@implementation CONGameState

NSString * const GameStateCardsArrayKey = @"kCONCardsArrayKey";
NSString * const GameStateScoreKey = @"kCONStateScoreKey";

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        _arrayOfCards = [aDecoder decodeObjectForKey:GameStateCardsArrayKey];
        _score = [aDecoder decodeObjectForKey:GameStateScoreKey];
    }
    return self;
}

- (instancetype)initNewGameWithDifficulty:(NSInteger)difficulty {
    if (self = [super init]) {
        _score = [[CONScore alloc] initWithScore:0 numberOfPairs:difficulty];
        NSMutableSet<CONCard *> *cardsSet = [NSMutableSet<CONCard *> new];
        for (int i = 0; i < difficulty; i++) {
            CONCard *card = [[CONCard alloc] initWithColor:[UIColor randomColor] andValue:i];
            [cardsSet addObject:card];
            [cardsSet addObject:[card copy]];
        }
        _arrayOfCards = [cardsSet allObjects];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.arrayOfCards forKey:GameStateCardsArrayKey];
    [aCoder encodeObject:self.score forKey:GameStateScoreKey];
}

- (void)setScore:(CONScore *)score {
    _score = score;
    if ([self.delegate respondsToSelector:@selector(scoreDidUpdate:)]) {
        [self.delegate scoreDidUpdate:score];
    }
}

- (void)incrementScore {
    self.score.score++;
    if ([self.delegate respondsToSelector:@selector(scoreDidUpdate:)]) {
        [self.delegate scoreDidUpdate:self.score];
    }
}

@end
