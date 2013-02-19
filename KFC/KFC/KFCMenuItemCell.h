//
//  KFCMenuItemCell.h
//  KFC
//
//  Created by Stanimir Nikolov on 2/19/13.
//  Copyright (c) 2013 Dobby. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol KFCMenuItemCellDelegate <NSObject>

- (void)likeButtonTappedForIndex:(CFIndex)index toState:(BOOL)isLiked;

@end

@interface KFCMenuItemCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *itemImageView;
@property (strong, nonatomic) IBOutlet UILabel *itemNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *itemDescriptionLabel;
@property (strong, nonatomic) IBOutlet UILabel *itemPriceLabel;
@property (weak, nonatomic) IBOutlet UIButton *likeButton;

@property (assign, nonatomic) BOOL isLiked;
@property (nonatomic, weak) id delegate;
@property (nonatomic, assign) CFIndex index;

- (IBAction)likedButtonTapped:(id)sender;


@end
