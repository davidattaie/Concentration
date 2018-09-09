//
//  CONGameStateController.h
//  concentration
//
//  Created by David Attaie on 9/9/18.
//  Copyright © 2018 David Attaie. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CONScore, CONGameState;

@interface CONGameStateController : NSObject

@property (nonatomic, nullable, strong, readonly) NSArray<CONScore *> *topScores;
@property (nonatomic, nullable, strong) CONGameState *currentGameState;

+ (CONGameStateController * __nonnull)sharedController;

- (void)saveScore:(CONScore *)score;
- (void)saveCurrentGameState;
- (void)clearLastSavedGameState;
- (void)restoreCurrentGameState;
- (void)createNewGameStateWithDifficulty:(NSInteger)difficulty;

@end
