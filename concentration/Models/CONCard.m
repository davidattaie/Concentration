//
//  CONCard.m
//  concentration
//
//  Created by David Attaie on 9/8/18.
//  Copyright © 2018 David Attaie. All rights reserved.
//

#import "CONCard.h"

@implementation CONCard

- (instancetype)initWithColor:(UIColor *)color andValue:(NSInteger)value {
    if (self = [super init]) {
        _color = color;
        _value = value;
    }
    return self;
}

- (id)copyWithZone:(NSZone *)zone {
    CONCard *copy = [[CONCard alloc] init];
    if (copy) {
        [copy setColor:[self.color copyWithZone:zone]];
        [copy setValue:self.value];
    }
    return copy;
}

@end
