//
//  CONScore.h
//  concentration
//
//  Created by David Attaie on 9/9/18.
//  Copyright © 2018 David Attaie. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CONScore : NSObject <NSCoding>

@property (nonatomic, assign) NSInteger score;
@property (nonatomic, assign) NSInteger numberOfPairs;

- (instancetype)initWithScore:(NSInteger)score numberOfPairs:(NSInteger)numberOfPairs;

@end
