//
//  NSManagedObject+ActiveRecord.h
//  WeatherTalentoMobile
//
//  Created by ANTONIO JIMÉNEZ MARTÍNEZ on 12/08/15.
//  Copyright (c) 2015 TalentoMobile. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface NSManagedObject (ActiveRecord)

+ (id)ar_createEntityInContext:(NSManagedObjectContext *)context;
+ (BOOL)ar_deleteAllMatchingPredicate:(NSPredicate *)predicate inContext:(NSManagedObjectContext *)context;

@end
