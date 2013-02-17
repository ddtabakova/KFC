//
//  KFCRestaurantsMapViewController.m
//  KFC
//
//  Created by Nikola Kirev on 17/02/2013.
//  Copyright (c) 2013 Dobby. All rights reserved.
//
#import <MapKit/MapKit.h>
#import "KFCRestaurantsMapViewController.h"

@interface KFCRestaurantsMapViewController ()
@property (strong, nonatomic) IBOutlet MKMapView *restaurantsMapView;
- (IBAction)showListAction:(id)sender;
@end

@implementation KFCRestaurantsMapViewController

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)showListAction:(id)sender {
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    
    //center the map on bulgaria
    CLLocationCoordinate2D centerCoordinate;
    centerCoordinate.latitude = 42.60162;
    centerCoordinate.longitude = 25.125732;
    CGFloat zoomScale = 400000.0;
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(centerCoordinate, zoomScale, zoomScale);
    MKCoordinateRegion adjustedRegion = [self.restaurantsMapView regionThatFits:viewRegion];
    [self.restaurantsMapView setRegion:adjustedRegion animated:YES];
}
@end
