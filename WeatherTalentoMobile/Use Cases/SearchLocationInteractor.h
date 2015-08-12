//
//  SearchLocationInteractor.h
//  WeatherTalentoMobile
//
//  Created by ANTONIO JIMÉNEZ MARTÍNEZ on 11/08/15.
//  Copyright (c) 2015 TalentoMobile. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LocationsProvider;

@interface SearchLocationInteractor : NSObject
@property (strong, nonatomic) LocationsProvider *locationsProvider;
- (void)searchLocationByName:(NSString *)locationName withCompletion:(void(^)(NSArray *array, NSError *error))completion;
@end
