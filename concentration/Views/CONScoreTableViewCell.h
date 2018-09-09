//
//  CONScoreTableViewCell.h
//  concentration
//
//  Created by David Attaie on 9/8/18.
//  Copyright © 2018 David Attaie. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CONScore;

@interface CONScoreTableViewCell : UITableViewCell

+ (NSString * __nonnull)cellIdentifier;

- (void)setupWithScore:(CONScore * __nullable)score;

@end
