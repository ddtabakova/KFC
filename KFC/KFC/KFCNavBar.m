//
//  KFCNavBar.m
//  KFC
//
//  Created by Stanimir Nikolov on 2/18/13.
//  Copyright (c) 2013 Dobby. All rights reserved.
//

#import "KFCNavBar.h"

@implementation KFCNavBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupBackground];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setupBackground];
    }
    return self;
}

- (void)setupBackground {
    [self setBackgroundImage:[UIImage imageNamed:@"navbar.png"] forBarMetrics:UIBarMetricsDefault];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
