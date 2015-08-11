//
//  NSManagedObject+Weather.h
//  WeatherTalentoMobile
//
//  Created by ANTONIO JIMÉNEZ MARTÍNEZ on 11/08/15.
//  Copyright (c) 2015 TalentoMobile. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface NSManagedObject (Weather)
- (instancetype)objectInManagedObjectContext:(NSManagedObjectContext *)managedObjectContext;
@end
