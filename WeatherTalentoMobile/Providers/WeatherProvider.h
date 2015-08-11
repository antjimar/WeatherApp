//
//  WeatherProvider.h
//  WeatherTalentoMobile
//
//  Created by ANTONIO JIMÉNEZ MARTÍNEZ on 11/08/15.
//  Copyright (c) 2015 TalentoMobile. All rights reserved.
//

#import "BaseProvider.h"

@interface WeatherProvider : BaseProvider

- (void)temperatureByCardinalLocation:(NSDictionary *)cardinalLocation withCompletion:(void(^)(NSNumber *averageTemperature, NSError *error))completion;
@end
