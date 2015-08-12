//
//  SaveLocationInteractor.m
//  WeatherTalentoMobile
//
//  Created by ANTONIO JIMÉNEZ MARTÍNEZ on 12/08/15.
//  Copyright (c) 2015 TalentoMobile. All rights reserved.
//

#import "SaveLocationInteractor.h"
#import "LocationsProvider.h"
#import "LocationEntity.h"

@implementation SaveLocationInteractor

- (void)saveLocationSelectedWithLocationEntity:(LocationEntity *)locationEntity withCompletion:(void(^)(NSError *error))completion {
    
    [self.locationsProvider saveLocationSelectedWithLocationEntity:locationEntity withCompletion:^(LocationSelectedEntity *locationSelectedEntity, NSError *error) {
        if (error) {
            if (completion) {
                completion(error);
            }
        } else {
            if (completion) {
                completion(nil);
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
