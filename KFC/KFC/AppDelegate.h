//
//  AppDelegate.h
//  KFC
//
//  Created by Dobby on 2/13/13.
//  Copyright (c) 2013 Dobby. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) User *currentUser;

@end
