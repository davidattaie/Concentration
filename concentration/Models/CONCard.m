//
//  CONCard.m
//  concentration
//
//  Created by David Attaie on 9/8/18.
//  Copyright © 2018 David Attaie. All rights reserved.
//

#import "CONCard.h"

@implementation CONCard

NSString * const ColorKey = @"kCONCardColorKey";
NSString * const ValueKey = @"kCONCardValueKey";
NSString * const RevealedKey = @"kCONCardRevealedKey";

- (instancetype)initWithColor:(UIColor *)color andValue:(NSInteger)value {
    if (self = [super init]) {
        _color = color;
        _value = value;
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        _color = [aDecoder decodeObjectForKey:ColorKey];
        _value = [aDecoder decodeIntegerForKey:ValueKey];
        _isRevealed = [aDecoder decodeBoolForKey:RevealedKey];
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

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.color forKey:ColorKey];
    [aCoder encodeInteger:self.value forKey:ValueKey];
    [aCoder encodeBool:self.isRevealed forKey:RevealedKey];
}

@end
