//
//  KFCFlipFromLeftSegue.m
//  KFC
//
//  Created by Nikola Kirev on 18/02/2013.
//  Copyright (c) 2013 Dobby. All rights reserved.
//

#import "KFCFlipFromLeftSegue.h"

@implementation KFCFlipFromLeftSegue

- (void)perform{
    UIViewController *src = (UIViewController *) self.sourceViewController;
    [UIView transitionWithView:src.navigationController.view duration:0.5
                       options:UIViewAnimationOptionTransitionFlipFromLeft
                    animations:^{
                        [src.navigationController popViewControllerAnimated:NO];
                    }
                    completion:nil];
}

@end
