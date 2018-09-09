//
//  CONNetworkingController.m
//  concentration
//
//  Created by David Attaie on 9/9/18.
//  Copyright © 2018 David Attaie. All rights reserved.
//

#import "CONNetworkingController.h"

@implementation CONNetworkingController

+ (CONNetworkingController *)sharedController {
    static CONNetworkingController *controller = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        controller = [CONNetworkingController new];
    });
    return controller;
}

- (void)loadGameStateFromServerWithCompletion:(void (^)(CONGameState * _Nullable))completion {
    // MOCK: Using URL Session or other networking service to load the game state from the server
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        completion(nil);
    });
}

- (void)saveGameStateToServer:(CONGameState *)gameState {
    // MOCK: Using URL Session or other networking service to upload the game state to the server
}

- (void)deleteLastGameStateFromServer {
    // MOCK: Using URL Session or other networking service to remove the game state from the server
}

@end
