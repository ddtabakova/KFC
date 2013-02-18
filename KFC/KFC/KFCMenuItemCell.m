//
//  KFCMenuItemCell.m
//  KFC
//
//  Created by Stanimir Nikolov on 2/19/13.
//  Copyright (c) 2013 Dobby. All rights reserved.
//

#import "KFCMenuItemCell.h"

@implementation KFCMenuItemCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
