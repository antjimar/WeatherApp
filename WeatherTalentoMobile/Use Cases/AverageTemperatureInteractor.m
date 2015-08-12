//
//  AverageTemperatureInteractor.m
//  WeatherTalentoMobile
//
//  Created by ANTONIO JIMÉNEZ MARTÍNEZ on 11/08/15.
//  Copyright (c) 2015 TalentoMobile. All rights reserved.
//

#import "AverageTemperatureInteractor.h"
#import "WeatherProvider.h"
#import "LocationSelectedEntity.h"

@implementation AverageTemperatureInteractor

- (void)averageTemperaturesWithLocationEntity:(LocationSelectedEntity *)locationSelectedEntity withCompletion:(void(^)(NSNumber *averageTemperature, NSError *error))completion {
    if ([self locationHasCardinalLocation:locationSelectedEntity]) {
        NSDictionary *cardinalLocation = @{
                                           @"north": [NSString stringWithFormat:@"%@", locationSelectedEntity.locationEntityNorthPoint],
                                           @"south": [NSString stringWithFormat:@"%@", locationSelectedEntity.locationEntitySouthPoint],
                                           @"east": [NSString stringWithFormat:@"%@", locationSelectedEntity.locationEntityEastPoint],
                                           @"west": [NSString stringWithFormat:@"%@", locationSelectedEntity.locationEntityWestPoint]
                                           };
        
        [self.weatherProvider temperaturesWeatherObservationsWithCardinalLocation:cardinalLocation withCompletion:^(NSArray *temperaturesWeatherObservations, NSError *error) {
            if (!error) {
                float temperatureTotal = 0;
                int temperatureNumber = 0;
                for (NSString *tempString in temperaturesWeatherObservations) {
                    temperatureTotal += [tempString floatValue];
                    temperatureNumber++;
                }
                if (completion) {
                    if ([temperaturesWeatherObservations count] > 0) {
                        float avgTemp = (float)temperatureTotal/(float)temperatureNumber;
                        completion(@(avgTemp), nil);
                    } else {
                        NSError *errorTempCount = [NSError errorWithDomain:@"weatherApp" code:991 userInfo:nil];
                        completion(nil, errorTempCount);
                    }

                }
            } else {
                if (completion) {
                    completion(nil, error);
                }
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
- (BOOL)locationHasCardinalLocation:(LocationSelectedEntity *)locationSelectedEntity {
    if (locationSelectedEntity.locationEntityEastPoint == 0
        && locationSelectedEntity.locationEntityWestPoint == 0
        && locationSelectedEntity.locationEntityNorthPoint == 0
        && locationSelectedEntity.locationEntitySouthPoint == 0) {
        return NO;
    }
    return YES;
}

#pragma mark - Getters Methods
- (WeatherProvider *)weatherProvider {
    if (!_weatherProvider) {
        _weatherProvider = [[WeatherProvider alloc] init];
    }
    return _weatherProvider;
}

@end
