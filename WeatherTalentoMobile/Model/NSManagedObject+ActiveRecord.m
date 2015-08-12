//
//  NSManagedObject+ActiveRecord.m
//  WeatherTalentoMobile
//
//  Created by ANTONIO JIMÉNEZ MARTÍNEZ on 12/08/15.
//  Copyright (c) 2015 TalentoMobile. All rights reserved.
//

#import "NSManagedObject+ActiveRecord.h"

@implementation NSManagedObject (ActiveRecord)

+ (id)ar_createEntityInContext:(NSManagedObjectContext *)context {
    return [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([self class]) inManagedObjectContext:context];
}

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
