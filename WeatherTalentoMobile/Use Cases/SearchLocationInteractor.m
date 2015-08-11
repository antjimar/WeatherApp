//
//  SearchLocationInteractor.m
//  WeatherTalentoMobile
//
//  Created by ANTONIO JIMÉNEZ MARTÍNEZ on 11/08/15.
//  Copyright (c) 2015 TalentoMobile. All rights reserved.
//

#import "SearchLocationInteractor.h"
#import "LocationsProvider.h"

@implementation SearchLocationInteractor

- (void)searchLocationByName:(NSString *)locationName withCompletion:(void(^)(NSArray *array, NSError *error))completion {
    [self.locationsProvider searchLocationByName:locationName withCompletion:^(NSArray *locations, NSError *error) {
        if (error) {
            if (completion) {
                completion(nil, error);
            }
        } else {
            if (completion) {
                completion(locations, nil);
            }
        }
    }];
}

#pragma mark - Getters Methods
- (LocationsProvider *)locationsProvider {
    if (!_locationsProvider) {
        _locationsProvider = [[LocationsProvider alloc] init];
    }
    return _locationsProvider;
}

@end
