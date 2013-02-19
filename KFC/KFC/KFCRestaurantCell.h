//
//  KFCRestaurantCell.h
//  KFC
//
//  Created by Nikola Kirev on 19/02/2013.
//  Copyright (c) 2013 Dobby. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KFCRestaurantCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UIImageView *photoImageView;
@property (nonatomic, strong) IBOutlet UILabel *nameLabel;
@property (nonatomic, strong) IBOutlet UILabel *addressLabel;

@end
