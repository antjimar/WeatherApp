//
//  AverageTemperatureInteractor.m
//  WeatherTalentoMobile
//
//  Created by ANTONIO JIMÉNEZ MARTÍNEZ on 11/08/15.
//  Copyright (c) 2015 TalentoMobile. All rights reserved.
//

#import "AverageTemperatureInteractor.h"
#import "WeatherProvider.h"
#import "LocationEntity.h"

@implementation AverageTemperatureInteractor

- (void)averageTemperaturesWithLocationEntity:(LocationEntity *)locationEntity withCompletion:(void(^)(NSNumber *averageTemperature, NSError *error))completion {
    if ([self locationHasCardinalLocation:locationEntity]) {
        NSDictionary *cardinalLocation = @{
                                           @"north": locationEntity.locationEntityNorthPoint,
                                           @"south": locationEntity.locationEntitySouthPoint,
                                           @"east": locationEntity.locationEntityEastPoint,
                                           @"west": locationEntity.locationEntityWestPoint
                                           };
        
        [self.weatherProvider temperaturesWeatherObservationsWithCardinalLocation:cardinalLocation withCompletion:^(NSArray *temperaturesWeatherObservations, NSError *error) {
            float temperatureTotal = 0;
            for (NSString *tempString in temperaturesWeatherObservations) {
                temperatureTotal += [tempString floatValue];
            }
            if (completion) {
                float avgTemp = (float)temperatureTotal/(float)[temperaturesWeatherObservations count];
                completion(@(avgTemp), nil);
            }
        }];
    } else {
        if (completion) {
            NSError *error = [NSError errorWithDomain:@"weatherApp" code:999 userInfo:nil];
            completion(nil, error);
        }
    }
}

#pragma mark - Private Methods
- (BOOL)locationHasCardinalLocation:(LocationEntity *)locationEntity {
    if (locationEntity.locationEntityEastPoint == 0
        && locationEntity.locationEntityWestPoint == 0
        && locationEntity.locationEntityNorthPoint == 0
        && locationEntity.locationEntitySouthPoint == 0) {
        return NO;
    }
    return YES;
}

@end
