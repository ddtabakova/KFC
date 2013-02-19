//
//  KFCMenuItemCell.m
//  KFC
//
//  Created by Stanimir Nikolov on 2/19/13.
//  Copyright (c) 2013 Dobby. All rights reserved.
//

#import "KFCMenuItemCell.h"

@implementation KFCMenuItemCell

@synthesize isLiked = _isLiked;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setIsLiked:(BOOL)isLiked {
    _isLiked = isLiked;
    [self.likeButton setContentMode:UIViewContentModeCenter];
    [self.likeButton setImage:[UIImage imageNamed:isLiked ? @"liked.png" : @"notliked.png"] forState:UIControlStateNormal];
}

- (IBAction)likedButtonTapped:(id)sender {
    [self setIsLiked:!self.isLiked];
    [self.delegate likeButtonTappedForIndex:self.index toState:self.isLiked];
}

@end
