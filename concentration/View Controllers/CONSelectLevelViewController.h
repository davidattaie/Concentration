//
//  CONSelectLevelViewController.h
//  concentration
//
//  Created by David Attaie on 9/8/18.
//  Copyright © 2018 David Attaie. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CONSelectLevelDelegate <NSObject>

- (void)didSelectLevel:(NSInteger)level;

@end

@interface CONSelectLevelViewController : UIViewController

@property (nonatomic, nullable, weak) id<CONSelectLevelDelegate> delegate;

@end
