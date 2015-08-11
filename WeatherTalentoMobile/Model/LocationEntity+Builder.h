//
//  LocationEntity+Builder.h
//  WeatherTalentoMobile
//
//  Created by ANTONIO JIMÉNEZ MARTÍNEZ on 11/08/15.
//  Copyright (c) 2015 TalentoMobile. All rights reserved.
//

#import "LocationEntity.h"

@interface LocationEntity (Builder)

+ (instancetype)parseLocationByDictionary:(NSDictionary *)data inManageObjectContext:(NSManagedObjectContext *)context;

@end
