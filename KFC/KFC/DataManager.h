//
//  DataManager.h
//  KFC
//
//  Created by Dobby on 2/14/13.
//  Copyright (c) 2013 Dobby. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataManager : NSObject
+ (NSManagedObjectContext *)managedObjectContext;
+ (void)saveDefaultData;
@end
