//
//  Type.h
//  KFC
//
//  Created by Dobby on 2/14/13.
//  Copyright (c) 2013 Dobby. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Type : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet *typeToMenu;
@end

@interface Type (CoreDataGeneratedAccessors)

- (void)addTypeToMenuObject:(NSManagedObject *)value;
- (void)removeTypeToMenuObject:(NSManagedObject *)value;
- (void)addTypeToMenu:(NSSet *)values;
- (void)removeTypeToMenu:(NSSet *)values;

@end
