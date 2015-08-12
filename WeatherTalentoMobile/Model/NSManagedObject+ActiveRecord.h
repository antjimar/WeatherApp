//
//  NSManagedObject+ActiveRecord.h
//  WeatherTalentoMobile
//
//  Created by ANTONIO JIMÉNEZ MARTÍNEZ on 12/08/15.
//  Copyright (c) 2015 TalentoMobile. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface NSManagedObject (ActiveRecord)

// CREATE
+ (id)ar_createEntityInContext:(NSManagedObjectContext *)context;

// READ
+ (NSArray *)ar_findAllInContext:(NSManagedObjectContext *)context;
+ (NSArray *)ar_findAllSortedBy:(NSString *)attribute ascending:(BOOL)ascending inContext:(NSManagedObjectContext *)context;
+ (NSArray *)ar_findAllSortedBy:(NSString *)attribute ascending:(BOOL)ascending withPredicate:(NSPredicate *)predicate inContext:(NSManagedObjectContext *)context;
+ (NSArray *)ar_findAllWithPredicate:(NSPredicate *)predicate inContext:(NSManagedObjectContext *)context;
+ (NSArray *)ar_findAllWithKey:(NSString *)key andValue:(NSString *)value inContext:(NSManagedObjectContext *)context;

+ (instancetype)ar_findFirstInContext:(NSManagedObjectContext *)context;
+ (instancetype)ar_findFirstWithPredicate:(NSPredicate *)predicate inContext:(NSManagedObjectContext *)context;
+ (instancetype)ar_findFirstWithKey:(NSString *)key andValue:(NSString *)value inContext:(NSManagedObjectContext *)context;

// DELETE
+ (BOOL)ar_deleteAllMatchingPredicate:(NSPredicate *)predicate inContext:(NSManagedObjectContext *)context;

@end
