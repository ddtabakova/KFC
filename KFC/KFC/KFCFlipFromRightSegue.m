//
//  KFCFlipFromRightSegue.m
//  KFC
//
//  Created by Nikola Kirev on 18/02/2013.
//  Copyright (c) 2013 Dobby. All rights reserved.
//

#import "KFCFlipFromRightSegue.h"

@implementation KFCFlipFromRightSegue

- (void)perform{
    UIViewController *src = (UIViewController *) self.sourceViewController;
    [UIView transitionWithView:src.navigationController.view duration:0.5
                       options:UIViewAnimationOptionTransitionFlipFromRight
                    animations:^{
                        [src.navigationController pushViewController:self.destinationViewController animated:NO];
                    }
                    completion:nil];
}

@end
