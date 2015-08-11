//
//  LocationEntity.m
//  WeatherTalentoMobile
//
//  Created by ANTONIO JIMÉNEZ MARTÍNEZ on 11/08/15.
//  Copyright (c) 2015 TalentoMobile. All rights reserved.
//

#import "LocationEntity.h"

@implementation LocationEntity

+ (instancetype)parseLocationByDictionary:(NSDictionary *)data {
    LocationEntity *locationEntity = [[LocationEntity alloc] init];
    locationEntity.locationEntityName = objectFromDictionaryValue(data[@"name"]);
    locationEntity.locationEntityEastPoint = @([objectFromDictionaryValue(data[@"east"]) doubleValue]);
    locationEntity.locationEntitySouthPoint = @([objectFromDictionaryValue(data[@"south"]) doubleValue]);
    locationEntity.locationEntityNorthPoint = @([objectFromDictionaryValue(data[@"north"]) doubleValue]);
    locationEntity.locationEntityWestPoint = @([objectFromDictionaryValue(data[@"west"]) doubleValue]);
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
