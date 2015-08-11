//
//  LocationsProvider.m
//  WeatherTalentoMobile
//
//  Created by ANTONIO JIMÉNEZ MARTÍNEZ on 11/08/15.
//  Copyright (c) 2015 TalentoMobile. All rights reserved.
//

#import "LocationsProvider.h"
#import "LocationEntity.h"

@implementation LocationsProvider

- (void)searchLocationByName:(NSString *)locationName withCompletion:(void(^)(NSArray *locations, NSError *error))completion {
    NSString *path = @"http://api.geonames.org/searchJSON";
    NSDictionary *params = @{
                             @"q": locationName,
                             @"maxRows": @"20",
                             @"startRow": @"0",
                             @"lang": @"en",
                             @"isNameRequired": @"true",
                             @"style": @"FULL",
                             @"username": @"ilgeonamessample"
                             };
    [self.requestManager GET:path parameters:params completion:^(NSData *responseObject) {
        NSMutableArray *locationsArray = [NSMutableArray array];
        NSError *errorJSON;
        NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:kNilOptions error:&errorJSON];
        if (errorJSON) {
            if (completion) {
                completion(nil, errorJSON);
            }
        }
        NSArray *geonamesArray = responseDictionary[@"geonames"];
        for (NSDictionary *geoname in geonamesArray) {
            [locationsArray addObject:[LocationEntity parseLocationByDictionary:geoname]];
        }
        if (completion) {
            completion(locationsArray, nil);
        }
    } error:^(id responseObject, NSError *error) {
        if (completion) {
            completion(nil, error);
        }
    }];
}


@end
