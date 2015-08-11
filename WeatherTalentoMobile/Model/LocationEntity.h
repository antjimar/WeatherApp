//
//  LocationEntity.h
//  WeatherTalentoMobile
//
//  Created by ANTONIO JIMÉNEZ MARTÍNEZ on 11/08/15.
//  Copyright (c) 2015 TalentoMobile. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LocationEntity : NSObject

@property (copy, nonatomic) NSString *locationEntityName;
@property (strong, nonatomic) NSNumber *locationEntityEastPoint;
@property (strong, nonatomic) NSNumber *locationEntitySouthPoint;
@property (strong, nonatomic) NSNumber *locationEntityNorthPoint;
@property (strong, nonatomic) NSNumber *locationEntityWestPoint;

+ (instancetype)parseLocationByDictionary:(NSDictionary *)data;

@end
