//
//  CONScoreTableViewCell.m
//  concentration
//
//  Created by David Attaie on 9/8/18.
//  Copyright © 2018 David Attaie. All rights reserved.
//

#import "CONScoreTableViewCell.h"
#import "CONScore.h"

@interface CONScoreTableViewCell()

@end

@implementation CONScoreTableViewCell

+ (NSString *)cellIdentifier {
    return NSStringFromClass(self);
}

- (void)setupWithScore:(CONScore *)score {
    [self.textLabel setTextAlignment:NSTextAlignmentCenter];
    NSString *scoreString = [NSString stringWithFormat:@"Score: %li  Difficulty(%li)", score.score, score.numberOfPairs];
    [self.textLabel setText:scoreString];
}

@end
