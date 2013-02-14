//
//  Image.h
//  KFC
//
//  Created by Dobby on 2/14/13.
//  Copyright (c) 2013 Dobby. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Restaurant;

@interface Image : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet *imageToRestaurant;
@end

@interface Image (CoreDataGeneratedAccessors)

- (void)addImageToRestaurantObject:(Restaurant *)value;
- (void)removeImageToRestaurantObject:(Restaurant *)value;
- (void)addImageToRestaurant:(NSSet *)values;
- (void)removeImageToRestaurant:(NSSet *)values;

@end
