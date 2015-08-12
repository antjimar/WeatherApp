//
//  LocationSelectedEntity.h
//  WeatherTalentoMobile
//
//  Created by ANTONIO JIMÉNEZ MARTÍNEZ on 12/08/15.
//  Copyright (c) 2015 TalentoMobile. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface LocationSelectedEntity : NSManagedObject

@property (nonatomic, retain) NSDate * locationSelectedDate;
@property (nonatomic, retain) NSNumber * locationEntityEastPoint;
@property (nonatomic, retain) NSNumber * locationEntityLatitude;
@property (nonatomic, retain) NSNumber * locationEntityLongitude;
@property (nonatomic, retain) NSString * locationEntityName;
@property (nonatomic, retain) NSNumber * locationEntityNorthPoint;
@property (nonatomic, retain) NSNumber * locationEntitySouthPoint;
@property (nonatomic, retain) NSNumber * locationEntityWestPoint;

@end
