//
//  CONGameStateController.h
//  concentration
//
//  Created by David Attaie on 9/9/18.
//  Copyright © 2018 David Attaie. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CONGameStateController : NSObject

@property (nonatomic, nullable, strong, readonly) NSArray<NSNumber *> *topScores;

+ (CONGameStateController * __nonnull)sharedController;

- (void)saveScore:(NSInteger)score;

@end
