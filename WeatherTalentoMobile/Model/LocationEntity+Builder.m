//
//  LocationEntity+Builder.m
//  WeatherTalentoMobile
//
//  Created by ANTONIO JIMÉNEZ MARTÍNEZ on 11/08/15.
//  Copyright (c) 2015 TalentoMobile. All rights reserved.
//

#import "LocationEntity+Builder.h"

@implementation LocationEntity (Builder)

+ (instancetype)parseLocationByDictionary:(NSDictionary *)data queryName:(NSString *)queryName inManageObjectContext:(NSManagedObjectContext *)context {
    LocationEntity *locationEntity = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([self class]) inManagedObjectContext:context];
    locationEntity.locationEntityName = objectFromDictionaryValue(data[@"name"]);
    locationEntity.locationEntityEastPoint = @([objectFromDictionaryValue(data[@"bbox"][@"east"]) doubleValue]);
    locationEntity.locationEntitySouthPoint = @([objectFromDictionaryValue(data[@"bbox"][@"south"]) doubleValue]);
    locationEntity.locationEntityNorthPoint = @([objectFromDictionaryValue(data[@"bbox"][@"north"]) doubleValue]);
    locationEntity.locationEntityWestPoint = @([objectFromDictionaryValue(data[@"bbox"][@"west"]) doubleValue]);
    locationEntity.locationEntityLongitude = @([objectFromDictionaryValue(data[@"lng"]) doubleValue]);
    locationEntity.locationEntityLatitude = @([objectFromDictionaryValue(data[@"lat"]) doubleValue]);
    locationEntity.locationEntityQuery = queryName;

    return locationEntity;
}

#pragma mark - Utils Methods
static inline id objectFromDictionaryValue(id value) {
    id returnVal;
    if([value isEqual:[NSNull null]] || value == nil){
        returnVal = nil;
    } else {
        returnVal = value;
    }
    return returnVal;
}

@end
