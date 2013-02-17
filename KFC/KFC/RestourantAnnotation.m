//
//  RestourantAnnotation.m
//  KFC
//
//  Created by Nikola Kirev on 17/02/2013.
//  Copyright (c) 2013 Dobby. All rights reserved.
//

#import "RestourantAnnotation.h"

@implementation RestourantAnnotation

- (id)initWithName:(NSString*)name address:(NSString*)address coordinate:(CLLocationCoordinate2D)coordinate{
    if ((self = [super init])) {
        self.restName = [name copy];
        self.restAddress = [address copy];
        self.restCoordinate = coordinate;
    }
    return self;
}

- (NSString *)title{
    return self.restName;
}

- (NSString *)subtitle{
    return self.restAddress;
}

- (CLLocationCoordinate2D)coordinate{
    return self.restCoordinate;
}



@end
