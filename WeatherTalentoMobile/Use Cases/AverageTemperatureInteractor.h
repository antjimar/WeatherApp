//
//  AverageTemperatureInteractor.h
//  WeatherTalentoMobile
//
//  Created by ANTONIO JIMÉNEZ MARTÍNEZ on 11/08/15.
//  Copyright (c) 2015 TalentoMobile. All rights reserved.
//

#import <Foundation/Foundation.h>

@class WeatherProvider, LocationSelectedEntity;

@interface AverageTemperatureInteractor : NSObject

@property (strong, nonatomic) WeatherProvider *weatherProvider;
- (void)averageTemperaturesWithLocationEntity:(LocationSelectedEntity *)locationSelectedEntity withCompletion:(void(^)(NSNumber *averageTemperature, NSError *error))completion;
@end
