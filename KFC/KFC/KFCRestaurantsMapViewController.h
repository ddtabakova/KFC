//
//  KFCRestaurantsMapViewController.h
//  KFC
//
//  Created by Nikola Kirev on 17/02/2013.
//  Copyright (c) 2013 Dobby. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>


@interface KFCRestaurantsMapViewController : UIViewController <MKMapViewDelegate, NSFetchedResultsControllerDelegate>

@property (nonatomic, strong) NSFetchedResultsController* resultsController;

@end
