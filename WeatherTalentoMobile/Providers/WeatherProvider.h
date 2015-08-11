//
//  WeatherProvider.h
//  WeatherTalentoMobile
//
//  Created by ANTONIO JIMÉNEZ MARTÍNEZ on 11/08/15.
//  Copyright (c) 2015 TalentoMobile. All rights reserved.
//

#import "BaseProvider.h"

@interface WeatherProvider : BaseProvider

- (void)temperaturesWeatherObservationsWithCardinalLocation:(NSDictionary *)cardinalLocation withCompletion:(void(^)(NSArray *temperaturesWeatherObservations, NSError *error))completion;

@end
