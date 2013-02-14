//
//  Menu.h
//  KFC
//
//  Created by Dobby on 2/14/13.
//  Copyright (c) 2013 Dobby. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Menu : NSManagedObject

@property (nonatomic, retain) NSString * desc;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * price;
@property (nonatomic, retain) NSString * image;
@property (nonatomic, retain) NSSet *menuToType;
@end

@interface Menu (CoreDataGeneratedAccessors)

- (void)addMenuToTypeObject:(NSManagedObject *)value;
- (void)removeMenuToTypeObject:(NSManagedObject *)value;
- (void)addMenuToType:(NSSet *)values;
- (void)removeMenuToType:(NSSet *)values;

@end
