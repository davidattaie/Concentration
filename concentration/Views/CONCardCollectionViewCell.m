//
//  CONCardCollectionViewCell.m
//  concentration
//
//  Created by David Attaie on 9/8/18.
//  Copyright © 2018 David Attaie. All rights reserved.
//

#import "CONCardCollectionViewCell.h"
#import "CONCard.h"

@implementation CONCardCollectionViewCell

+ (NSString *)cellIdentifier {
    return NSStringFromClass(self);
}

- (void)setupWithCard:(CONCard *)card {
    //setup and configure the view with the card
    [self setBackgroundColor:[card color]];
}

@end
