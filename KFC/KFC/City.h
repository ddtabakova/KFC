//
//  City.h
//  KFC
//
//  Created by Dobby on 2/14/13.
//  Copyright (c) 2013 Dobby. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Restaurant;

@interface City : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet *cityToRestaurant;
@end

@interface City (CoreDataGeneratedAccessors)

- (void)addCityToRestaurantObject:(Restaurant *)value;
- (void)removeCityToRestaurantObject:(Restaurant *)value;
- (void)addCityToRestaurant:(NSSet *)values;
- (void)removeCityToRestaurant:(NSSet *)values;

@end
