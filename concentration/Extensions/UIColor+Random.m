//
//  UIColor+Random.m
//  concentration
//
//  Created by David Attaie on 9/8/18.
//  Copyright © 2018 David Attaie. All rights reserved.
//

#import "UIColor+Random.h"

@implementation UIColor(Random)

+ (UIColor *)randomColor {
    uint32_t redVal = arc4random_uniform(255);
    uint32_t greenVal = arc4random_uniform(255);
    uint32_t blueVal = arc4random_uniform(255);
    return [UIColor colorWithRed:redVal/255.0f green:greenVal/255.0f blue:blueVal/255.0f alpha:1.0f];
}

@end
