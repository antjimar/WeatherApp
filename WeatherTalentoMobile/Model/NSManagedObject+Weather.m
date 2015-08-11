//
//  NSManagedObject+Weather.m
//  WeatherTalentoMobile
//
//  Created by ANTONIO JIMÉNEZ MARTÍNEZ on 11/08/15.
//  Copyright (c) 2015 TalentoMobile. All rights reserved.
//

#import "NSManagedObject+Weather.h"

@implementation NSManagedObject (Weather)

- (instancetype)objectInManagedObjectContext:(NSManagedObjectContext *)managedObjectContext {
    if (managedObjectContext == self.managedObjectContext) {
        return self;
    }
    __block NSManagedObject *object;
    NSManagedObjectID *objectId = [self.objectID copy];
    [managedObjectContext performBlockAndWait:^{
        object = [managedObjectContext objectWithID:objectId];
    }];
    return object;
}

@end
