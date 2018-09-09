//
//  CONGameViewController.h
//  concentration
//
//  Created by David Attaie on 9/8/18.
//  Copyright © 2018 David Attaie. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CONGameState;

@interface CONGameViewController : UIViewController

- (instancetype)initWithGameState:(CONGameState *)gameState;

@end
