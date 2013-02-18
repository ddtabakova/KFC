//
//  KFCMenuItemCell.h
//  KFC
//
//  Created by Stanimir Nikolov on 2/19/13.
//  Copyright (c) 2013 Dobby. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KFCMenuItemCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *itemImageView;
@property (strong, nonatomic) IBOutlet UILabel *itemNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *itemDescriptionLabel;
@property (strong, nonatomic) IBOutlet UILabel *itemPriceLabel;
@end
