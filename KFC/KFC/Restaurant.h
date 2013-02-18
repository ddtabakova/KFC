//
//  Restaurant.h
//  KFC
//
//  Created by Dobby on 2/14/13.
//  Copyright (c) 2013 Dobby. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class City, Image;

@interface Restaurant : NSManagedObject

@property (nonatomic, retain) NSString * address;
@property (nonatomic, retain) NSNumber * hasAirCond;
@property (nonatomic, retain) NSNumber * hasDelivery;
@property (nonatomic, retain) NSNumber * hasDunken;
@property (nonatomic, retain) NSNumber * hasKidsLanding;
@property (nonatomic, retain) NSNumber * hasKidsParties;
@property (nonatomic, retain) NSNumber * hasOutdoor;
@property (nonatomic, retain) NSNumber * hasParking;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * workingTime;
@property (nonatomic, retain) NSSet *restaurantToCity;
@property (nonatomic, retain) NSSet *restaurantToImage;
@property (nonatomic, retain) NSNumber * lat;
@property (nonatomic, retain) NSNumber * lon;
@end

@interface Restaurant (CoreDataGeneratedAccessors)

- (void)addRestaurantToCityObject:(City *)value;
- (void)removeRestaurantToCityObject:(City *)value;
- (void)addRestaurantToCity:(NSSet *)values;
- (void)removeRestaurantToCity:(NSSet *)values;

- (void)addRestaurantToImageObject:(Image *)value;
- (void)removeRestaurantToImageObject:(Image *)value;
- (void)addRestaurantToImage:(NSSet *)values;
- (void)removeRestaurantToImage:(NSSet *)values;

@end
