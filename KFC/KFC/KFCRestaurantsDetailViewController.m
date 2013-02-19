//
//  RestaurantsDetailViewController.m
//  KFC
//
//  Created by Nikola Kirev on 18/02/2013.
//  Copyright (c) 2013 Dobby. All rights reserved.
//

#import "KFCRestaurantsDetailViewController.h"

@interface KFCRestaurantsDetailViewController ()
@property (strong, nonatomic) IBOutlet UIImageView *hasACView;
@property (strong, nonatomic) IBOutlet UIImageView *hasDeliveryView;
@property (strong, nonatomic) IBOutlet UIImageView *hasDunkenView;
@property (strong, nonatomic) IBOutlet UIImageView *hasKidsLandingView;
@property (strong, nonatomic) IBOutlet UIImageView *hasKidsPartiesView;
@property (strong, nonatomic) IBOutlet UIImageView *hasOutdoorView;
@property (strong, nonatomic) IBOutlet UIImageView *hasParkingView;
@property (strong, nonatomic) IBOutlet UIImageView *photoImageView;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *addressLabel;
@property (strong, nonatomic) IBOutlet UILabel *worktimeLabel;
- (IBAction)actionButtonPressed:(id)sender;
@end

@implementation KFCRestaurantsDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self.nameLabel setText:self.restaurant.name];
    [self.addressLabel setText:self.restaurant.address];
    [self.worktimeLabel setText:self.restaurant.workingTime];
    [self.photoImageView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@.jpg", self.restaurant.name]]];
    
    if (![self.restaurant.hasAirCond boolValue]) {
        [self.hasACView setAlpha:0.4f];
    }
    if (![self.restaurant.hasDelivery boolValue]) {
        [self.hasDeliveryView setAlpha:0.6f];
    }
    if (![self.restaurant.hasDunken boolValue]) {
        [self.hasDunkenView setAlpha:0.6f];
    }
    if (![self.restaurant.hasKidsParties boolValue]) {
        [self.hasKidsPartiesView setAlpha:0.6f];
    }
    if (![self.restaurant.hasOutdoor boolValue]) {
        [self.hasOutdoorView setAlpha:0.6f];
    }
    if (![self.restaurant.hasParking boolValue]) {
        [self.hasParkingView setAlpha:0.6f];
    }
    if (![self.restaurant.hasKidsLanding boolValue]) {
        [self.hasKidsLandingView setAlpha:0.6f];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)actionButtonPressed:(id)sender {
    if (NSClassFromString(@"UIActivityViewController")) {
        UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:@[[UIImage imageNamed:[NSString stringWithFormat:@"%@.jpg", self.restaurant.name]], @"Хайде да хапнем в KFC!"] applicationActivities:nil];
        [activityVC setExcludedActivityTypes:@[UIActivityTypeAssignToContact, UIActivityTypeCopyToPasteboard, UIActivityTypePrint, UIActivityTypeSaveToCameraRoll]];
        [self presentViewController:activityVC animated:YES completion:nil];
    }
}

@end
