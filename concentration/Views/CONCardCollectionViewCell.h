//
//  CONCardCollectionViewCell.h
//  concentration
//
//  Created by David Attaie on 9/8/18.
//  Copyright © 2018 David Attaie. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CONCard;

@interface CONCardCollectionViewCell : UICollectionViewCell

- (void)setupWithCard:(CONCard * __nonnull)card;
+ (NSString * __nonnull)cellIdentifier;

@end
