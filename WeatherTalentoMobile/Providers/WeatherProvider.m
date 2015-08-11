//
//  WeatherProvider.m
//  WeatherTalentoMobile
//
//  Created by ANTONIO JIMÉNEZ MARTÍNEZ on 11/08/15.
//  Copyright (c) 2015 TalentoMobile. All rights reserved.
//

#import "WeatherProvider.h"

@implementation WeatherProvider

- (void)temperaturesWeatherObservationsWithCardinalLocation:(NSDictionary *)cardinalLocation withCompletion:(void(^)(NSArray *temperaturesWeatherObservations, NSError *error))completion {
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
        
        NSArray *weathersArray = objectFromDictionaryValue(responseDictionary[@"weatherObservations"]);
        NSMutableArray *temperatures = [[NSMutableArray alloc] init];
        for (NSDictionary *weatherDictionary in weathersArray) {
            [temperatures addObject:objectFromDictionaryValue(weatherDictionary[@"temperature"])];
        }
        
        if (completion) {
            completion([temperatures mutableCopy], nil);
        }
    } error:^(id responseObject, NSError *error) {
        if (completion) {
            completion(nil, error);
        }
    }];
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
