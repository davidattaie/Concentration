//
//  CONGameStateController.h
//  concentration
//
//  Created by David Attaie on 9/9/18.
//  Copyright © 2018 David Attaie. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CONScore;

@interface CONGameStateController : NSObject

@property (nonatomic, nullable, strong, readonly) NSArray<CONScore *> *topScores;

+ (CONGameStateController * __nonnull)sharedController;

- (void)saveScore:(NSInteger)score withCardCount:(NSInteger)count;

@end
