//
//  DataManager.h
//  KFC
//
//  Created by Dobby on 2/14/13.
//  Copyright (c) 2013 Dobby. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@interface DataManager : NSObject

+ (NSManagedObjectContext *)managedObjectContext;
+ (void)saveDefaultData;
+ (void)addNewUser:(NSString*)userEmail withCompletion:(void(^)(NSError *error))completion;
+ (void)userForEmail:(NSString*)email withCompletion:(void(^)(User *user, NSError *error))completion;
+ (void)addMenuItem:(Menu*)menuItem toUserFavorites:(User*)user withCompletion:(void(^)(NSError *error))completion;
+ (void)removeMenuItem:(Menu*)menuItem toUserFavorites:(User*)user withCompletion:(void(^)(NSError *error))completion;

@end
