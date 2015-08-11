//
//  LocationsProvider.m
//  WeatherTalentoMobile
//
//  Created by ANTONIO JIMÉNEZ MARTÍNEZ on 11/08/15.
//  Copyright (c) 2015 TalentoMobile. All rights reserved.
//

#import "LocationsProvider.h"
#import "LocationEntity+Builder.h"
#import "NSManagedObject+Weather.h"

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
        __weak typeof(self) weakSelf = self;
        [self.writeManagedObjectContext performBlock:^{
            __strong typeof(weakSelf) self = weakSelf;
            NSError *errorJSON;
            NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:kNilOptions error:&errorJSON];
            if (errorJSON) {
                if (completion) {
                    completion(nil, errorJSON);
                }
            }
            NSMutableArray *locationsCache = [NSMutableArray array];
            for (NSDictionary *geoname in responseDictionary[@"geonames"]) {
                LocationEntity *locationEntity = [LocationEntity parseLocationByDictionary:geoname inManageObjectContext:self.writeManagedObjectContext];
                [locationsCache addObject:locationEntity];
            }
            NSError *coreDataError;
            [self.writeManagedObjectContext save:&coreDataError];
            if (coreDataError) {
                NSLog(@"%@", coreDataError);
            }
            if (completion) {
                NSMutableArray *mainThreadLocations = [NSMutableArray array];
                for (LocationEntity *mainThreadLocationEntity in locationsCache) {
                    [mainThreadLocations addObject:[mainThreadLocationEntity objectInManagedObjectContext:self.managedObjectContext]];
                }
                dispatch_async(dispatch_get_main_queue(), ^{
                    completion([mainThreadLocations copy], nil);
                });
            }
        }];

    } error:^(id responseObject, NSError *error) {
        if (completion) {
            completion(nil, error);
        }
    }];
}


@end
