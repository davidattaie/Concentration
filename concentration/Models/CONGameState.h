//
//  CONGameState.h
//  concentration
//
//  Created by David Attaie on 9/9/18.
//  Copyright © 2018 David Attaie. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CONCard, CONScore;

@protocol CONGameStateDelegate<NSObject>

- (void)scoreDidUpdate:(CONScore *)score;

@end

@interface CONGameState : NSObject <NSCoding>

@property (nonatomic, nullable, strong) CONScore *score;
@property (nonatomic, nullable, strong) NSArray<CONCard *> *arrayOfCards;
@property (nonatomic, nullable, weak) id<CONGameStateDelegate> delegate;

- (instancetype)initNewGameWithDifficulty:(NSInteger)difficulty;
- (void)incrementScore;

@end
