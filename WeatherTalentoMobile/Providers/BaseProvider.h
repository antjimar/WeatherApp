//
//  BaseProvider.h
//  WeatherTalentoMobile
//
//  Created by ANTONIO JIMÉNEZ MARTÍNEZ on 11/08/15.
//  Copyright (c) 2015 TalentoMobile. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RequestManager.h"

@interface BaseProvider : NSObject

@property (strong, nonatomic) id<RequestManager> requestManager;

@end
