//
//  KFCRestaurantsMapViewController.m
//  KFC
//
//  Created by Nikola Kirev on 17/02/2013.
//  Copyright (c) 2013 Dobby. All rights reserved.
//
#import <MapKit/MapKit.h>
#import "KFCRestaurantsMapViewController.h"
#import "DataManager.h"
#import "Restaurant.h"
#import "RestourantAnnotation.h"
#import "KFCRestaurantsDetailViewController.h"

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
	NSManagedObjectContext *moc = [DataManager managedObjectContext];
	NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Restaurant" inManagedObjectContext:moc];
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
	NSFetchRequest *request = [[NSFetchRequest alloc] init];
	[request setEntity:entityDescription];
    [request setSortDescriptors:[NSArray arrayWithObject:sortDescriptor]];
    
    self.resultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:moc sectionNameKeyPath:nil cacheName:@"restaurant_list.cache"];
    self.resultsController.delegate = self;
    
    NSError* error;
	BOOL success = [self.resultsController performFetch:&error];
    
    if (!success) {
        NSLog(@"The objects cannot be retrieved");
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"ShowDetailFromMap"]) {
        KFCRestaurantsDetailViewController *destinationVC = [segue destinationViewController];
        [destinationVC setRestaurant:sender];
    }
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
    [self plotRestaurantObjects];
}

#pragma Mark - MapViewDelegate

- (void) plotRestaurantObjects{
    for (Restaurant *restaurantObject in [self.resultsController fetchedObjects]) {
        NSNumber *latitude = [restaurantObject lat];
        NSNumber *longitude = [restaurantObject lon];
        NSString *name = [restaurantObject name];
        NSString *address = [restaurantObject address];
        CLLocationCoordinate2D coordinate;
        coordinate.latitude = [latitude doubleValue];
        coordinate.longitude = longitude.doubleValue;
        RestourantAnnotation *annotation = [[RestourantAnnotation alloc] initWithName:name address:address coordinate:coordinate];
        annotation.annotationTag = [[self.resultsController indexPathForObject:restaurantObject] row];
        [self.restaurantsMapView addAnnotation:annotation];
    }
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation{
    
    static NSString *identifier = @"RentAnnotation";
    if ([annotation isKindOfClass:[RestourantAnnotation class]]) {
        
        MKPinAnnotationView *annotationView = (MKPinAnnotationView *) [self.restaurantsMapView dequeueReusableAnnotationViewWithIdentifier:identifier];
        if (annotationView == nil) {
            annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
        } else {
            annotationView.annotation = annotation;
        }
        
        annotationView.enabled = YES;
        annotationView.canShowCallout = YES;
        annotationView.tag = ((RestourantAnnotation *)annotation).annotationTag;
        UIButton *detailButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        annotationView.rightCalloutAccessoryView = detailButton;
        
        return annotationView;
    }
    
    return nil;
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control{
    [self performSegueWithIdentifier:@"ShowDetailFromMap" sender:[[self.resultsController fetchedObjects] objectAtIndex:[((RestourantAnnotation *)view.annotation) annotationTag]]];
}

@end
