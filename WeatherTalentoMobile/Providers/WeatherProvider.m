//
//  WeatherProvider.m
//  WeatherTalentoMobile
//
//  Created by ANTONIO JIMÉNEZ MARTÍNEZ on 11/08/15.
//  Copyright (c) 2015 TalentoMobile. All rights reserved.
//

#import "WeatherProvider.h"

@implementation WeatherProvider

- (void)temperatureByCardinalLocation:(NSDictionary *)cardinalLocation withCompletion:(void(^)(NSNumber *averageTemperature, NSError *error))completion {
    NSString *path = @"http://api.geonames.org/weatherJSON";
    NSMutableDictionary *paramsMutable = [NSMutableDictionary dictionaryWithDictionary:cardinalLocation];
    [paramsMutable setValue:@"demo" forKey:@"username"];
    NSDictionary *params = [paramsMutable mutableCopy];
    
    [self.requestManager GET:path parameters:params completion:^(NSData *responseObject) {
        NSError *errorJSON;
        NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:kNilOptions error:&errorJSON];
        if (errorJSON) {
            if (completion) {
                completion(nil, errorJSON);
            }
        }
        NSArray *weathersArray = responseDictionary[@"weatherObservations"];
        NSInteger temperatureTotal = 0;
        for (NSDictionary *weatherDictionary in weathersArray) {
            temperatureTotal += [weatherDictionary[@"temperature"] integerValue];
        }
        if (completion) {
            float avgTemp = (float)temperatureTotal/(float)[weathersArray count];
            completion(@(avgTemp), nil);
        }
    } error:^(id responseObject, NSError *error) {
        if (completion) {
            completion(nil, error);
        }
    }];
}

@end
