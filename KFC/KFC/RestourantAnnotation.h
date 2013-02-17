//
//  RestourantAnnotation.h
//  KFC
//
//  Created by Nikola Kirev on 17/02/2013.
//  Copyright (c) 2013 Dobby. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface RestourantAnnotation : NSObject<MKAnnotation>

@property (nonatomic, strong) NSString *restName;
@property (nonatomic, strong) NSString *restAddress;
@property (nonatomic, assign) CLLocationCoordinate2D restCoordinate;
@property (nonatomic, assign) int annotationTag;

- (id)initWithName:(NSString*)name address:(NSString*)address coordinate:(CLLocationCoordinate2D)coordinate;

@end
