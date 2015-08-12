//
//  NSManagedObject+ActiveRecord.m
//  WeatherTalentoMobile
//
//  Created by ANTONIO JIMÉNEZ MARTÍNEZ on 12/08/15.
//  Copyright (c) 2015 TalentoMobile. All rights reserved.
//

#import "NSManagedObject+ActiveRecord.h"

@implementation NSManagedObject (ActiveRecord)

// CREATE
+ (id)ar_createEntityInContext:(NSManagedObjectContext *)context {
    return [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([self class]) inManagedObjectContext:context];
}

// READ
+ (NSArray *)ar_findAllInContext:(NSManagedObjectContext *)context {
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:NSStringFromClass([self class])];
    NSError *fetchError;
    NSArray *fetchResult = [context executeFetchRequest:fetchRequest error:&fetchError];
    if (fetchError) {
        NSLog(@"%@", fetchError);
    }
    return fetchResult;
}
+ (NSArray *)ar_findAllSortedBy:(NSString *)attribute ascending:(BOOL)ascending inContext:(NSManagedObjectContext *)context {
    return [self ar_findAllSortedBy:attribute ascending:ascending withPredicate:nil inContext:context];
}
+ (NSArray *)ar_findAllSortedBy:(NSString *)attribute ascending:(BOOL)ascending withPredicate:(NSPredicate *)predicate inContext:(NSManagedObjectContext *)context {
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:NSStringFromClass([self class])];
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:attribute ascending:ascending];
    fetchRequest.sortDescriptors = @[sortDescriptor];
    fetchRequest.predicate = predicate;
    NSError *fetchError;
    NSArray *fetchResult = [context executeFetchRequest:fetchRequest error:&fetchError];
    if (fetchError) {
        NSLog(@"%@", fetchError);
    }
    return fetchResult;
}
+ (NSArray *)ar_findAllWithPredicate:(NSPredicate *)predicate inContext:(NSManagedObjectContext *)context {
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:NSStringFromClass([self class])];
    fetchRequest.predicate = predicate;
    NSError *fetchError;
    NSArray *fetchResult = [context executeFetchRequest:fetchRequest error:&fetchError];
    if (fetchError) {
        NSLog(@"%@", fetchError);
    }
    return fetchResult;
}
+ (NSArray *)ar_findAllWithKey:(NSString *)key andValue:(NSString *)value inContext:(NSManagedObjectContext *)context {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%K = %@", key, value];
    return [self ar_findAllWithPredicate:predicate inContext:context];
}
+ (instancetype)ar_findFirstInContext:(NSManagedObjectContext *)context {
    return [self ar_findFirstWithPredicate:nil inContext:context];
}
+ (instancetype)ar_findFirstWithPredicate:(NSPredicate *)predicate inContext:(NSManagedObjectContext *)context {
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:NSStringFromClass([self class])];
    fetchRequest.fetchLimit = 1;
    fetchRequest.predicate = predicate;
    NSError *fetchError;
    NSArray *fetchResult = [context executeFetchRequest:fetchRequest error:&fetchError];
    if (fetchError) {
        NSLog(@"%@", fetchError);
    }
    NSManagedObject *matchedObject = [fetchResult lastObject];
    return matchedObject;
}
+ (instancetype)ar_findFirstWithKey:(NSString *)key andValue:(NSString *)value inContext:(NSManagedObjectContext *)context {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%K = %@", key, value];
    return [self ar_findFirstWithPredicate:predicate inContext:context];
}

// DELETE
+ (BOOL)ar_deleteAllMatchingPredicate:(NSPredicate *)predicate inContext:(NSManagedObjectContext *)context {
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:NSStringFromClass([self class])];
    fetchRequest.predicate = predicate;
    NSError *fetchError;
    NSArray *fetchResult = [context executeFetchRequest:fetchRequest error:&fetchError];
    if (fetchError) {
        NSLog(@"%@", fetchError);
        return NO;
    }
    for (NSManagedObject *object in fetchResult) {
        [context deleteObject:object];
    }
    return YES;
}

@end
