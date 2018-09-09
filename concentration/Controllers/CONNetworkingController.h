//
//  CONNetworkingController.h
//  concentration
//
//  Created by David Attaie on 9/9/18.
//  Copyright © 2018 David Attaie. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CONGameState;

@interface CONNetworkingController : NSObject

+ (CONNetworkingController * __nonnull)sharedController;

- (void)loadGameStateFromServerWithCompletion:(void (^)(CONGameState * _Nullable))completion;
- (void)saveGameStateToServer:(CONGameState *)gameState;
- (void)deleteLastGameStateFromServer;

@end
