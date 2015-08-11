//
//  RequestManagerFactory.m
//  WeatherTalentoMobile
//
//  Created by ANTONIO JIMÉNEZ MARTÍNEZ on 11/08/15.
//  Copyright (c) 2015 TalentoMobile. All rights reserved.
//

#import "RequestManagerFactory.h"
#import "HTTPRequestManager.h"

@implementation RequestManagerFactory

+ (id<RequestManager>)httpRequestManager {
    return [[HTTPRequestManager alloc] init];
}

@end
