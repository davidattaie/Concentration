//
//  CONScore.m
//  concentration
//
//  Created by David Attaie on 9/9/18.
//  Copyright © 2018 David Attaie. All rights reserved.
//

#import "CONScore.h"

@implementation CONScore

NSString * const ScoreKey = @"kCONScoreKey";
NSString * const CardCountKey = @"kCONCardCountKey";

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        _score = [aDecoder decodeIntegerForKey:ScoreKey];
        _numberOfPairs = [aDecoder decodeIntegerForKey:CardCountKey];
    }
    return self;
}

- (instancetype)initWithScore:(NSInteger)score numberOfPairs:(NSInteger)numberOfPairs {
    if(self = [super init]) {
        _score = score;
        _numberOfPairs = numberOfPairs;
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeInteger:self.score forKey:ScoreKey];
    [aCoder encodeInteger:self.numberOfPairs forKey:CardCountKey];
}

@end
