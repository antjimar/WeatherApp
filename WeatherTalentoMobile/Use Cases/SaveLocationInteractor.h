//
//  SaveLocationInteractor.h
//  WeatherTalentoMobile
//
//  Created by ANTONIO JIMÉNEZ MARTÍNEZ on 12/08/15.
//  Copyright (c) 2015 TalentoMobile. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LocationEntity, LocationsProvider;

@interface SaveLocationInteractor : NSObject
@property (strong, nonatomic) LocationsProvider *locationsProvider;
- (void)saveLocationSelectedWithLocationEntity:(LocationEntity *)locationEntity withCompletion:(void(^)(NSError *error))completion;
@end
