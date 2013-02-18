//
//  KFCBackground.m
//  KFC
//
//  Created by Stanimir Nikolov on 2/18/13.
//  Copyright (c) 2013 Dobby. All rights reserved.
//

#import "KFCBackground.h"

@implementation KFCBackground

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        
    }
    return self;
}

- (void)setupBackground {
    [self setImage:[UIImage imageNamed:@"bg.png"]];
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
