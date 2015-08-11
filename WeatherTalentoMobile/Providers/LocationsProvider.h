//
//  LocationsProvider.h
//  WeatherTalentoMobile
//
//  Created by ANTONIO JIMÉNEZ MARTÍNEZ on 11/08/15.
//  Copyright (c) 2015 TalentoMobile. All rights reserved.
//

#import "BaseProvider.h"

@interface LocationsProvider : BaseProvider

- (void)searchLocationByName:(NSString *)locationName withCompletion:(void(^)(NSArray *locations, NSError *error))completion;

@end
