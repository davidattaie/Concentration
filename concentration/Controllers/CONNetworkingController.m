//
//  CONNetworkingController.m
//  concentration
//
//  Created by David Attaie on 9/9/18.
//  Copyright © 2018 David Attaie. All rights reserved.
//

#import "CONNetworkingController.h"
#import "CONGameState.h"

@interface CONNetworkingController()

@property (nonatomic, nullable, strong) NSString *userGuid;

@end

@implementation CONNetworkingController

NSString * const UserGUID = @"kCONUserGUIDKey";
const BOOL MockingEnabled = YES;

+ (CONNetworkingController *)sharedController {
    static CONNetworkingController *controller = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        controller = [CONNetworkingController new];
    });
    return controller;
}

- (NSString *)userGuid {
    if (!_userGuid) {
        NSString *guid = [[NSUserDefaults standardUserDefaults] stringForKey:UserGUID];
        if(!guid) {
            NSUUID *rawUUID = [NSUUID UUID];
            guid = [rawUUID UUIDString];
            [[NSUserDefaults standardUserDefaults] setObject:guid forKey:UserGUID];
        }
        _userGuid = guid;
    }
    return _userGuid;
}

- (void)loadGameStateFromServerWithCompletion:(void (^)(CONGameState * _Nullable))completion {
    // MOCK: Using URL Session or other networking service to load the game state from the server
    if (MockingEnabled) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            completion(nil);
        });
    } else {
        NSString *urlString = [NSString stringWithFormat:@"https://www.ourfakedomain.com/%@/state", self.userGuid];
        NSURL *url = [NSURL URLWithString:urlString];
        NSMutableURLRequest *urlRequest = [[NSMutableURLRequest alloc] initWithURL:url];
        [urlRequest setHTTPMethod:@"GET"];
        
        NSURLSession *session = [NSURLSession sharedSession];
        NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                CONGameState *gameState = [NSKeyedUnarchiver unarchiveObjectWithData:data];
                if (completion) {
                    completion(gameState);
                }
            });
        }];
        [dataTask resume];
    }
}

- (void)saveGameStateToServer:(CONGameState *)gameState {
    // MOCK: Using URL Session or other networking service to upload the game state to the server
    if (!MockingEnabled) {
        NSString *urlString = [NSString stringWithFormat:@"https://www.ourfakedomain.com/%@/state", self.userGuid];
        NSURL *url = [NSURL URLWithString:urlString];
        NSMutableURLRequest *urlRequest = [[NSMutableURLRequest alloc] initWithURL:url];
        [urlRequest setHTTPMethod:@"POST"];
        [urlRequest setHTTPBody:[NSKeyedArchiver archivedDataWithRootObject:gameState]];
        
        NSURLSession *session = [NSURLSession sharedSession];
        NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            //Handle response if desired
        }];
        [dataTask resume];
    }
}

- (void)deleteLastGameStateFromServer {
    // MOCK: Using URL Session or other networking service to remove the game state from the server
    if (!MockingEnabled) {
        NSString *urlString = [NSString stringWithFormat:@"https://www.ourfakedomain.com/%@/state", self.userGuid];
        NSURL *url = [NSURL URLWithString:urlString];
        NSMutableURLRequest *urlRequest = [[NSMutableURLRequest alloc] initWithURL:url];
        [urlRequest setHTTPMethod:@"DELETE"];
        
        NSURLSession *session = [NSURLSession sharedSession];
        NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            //Handle response if desired
        }];
        [dataTask resume];
    }
}

@end
