//
//  CONCard.h
//  concentration
//
//  Created by David Attaie on 9/8/18.
//  Copyright © 2018 David Attaie. All rights reserved.
//

@import UIKit;

@interface CONCard : NSObject <NSCopying>

@property (nonatomic, nullable, strong) UIColor *color;
@property (nonatomic, assign) NSInteger value;

- (instancetype)initWithColor:(UIColor *)color andValue:(NSInteger)value;

@end