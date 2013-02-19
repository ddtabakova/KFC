//
//  User.h
//  KFC
//
//  Created by Dobby on 2/19/13.
//  Copyright (c) 2013 Dobby. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Menu;

@interface User : NSManagedObject

@property (nonatomic, retain) NSString * email;
@property (nonatomic, retain) NSSet *userToMenu;
@end

@interface User (CoreDataGeneratedAccessors)

- (void)addUserToMenuObject:(Menu *)value;
- (void)removeUserToMenuObject:(Menu *)value;
- (void)addUserToMenu:(NSSet *)values;
- (void)removeUserToMenu:(NSSet *)values;

@end
