//
//  BaseProvider.m
//  WeatherTalentoMobile
//
//  Created by ANTONIO JIMÉNEZ MARTÍNEZ on 11/08/15.
//  Copyright (c) 2015 TalentoMobile. All rights reserved.
//

#import "BaseProvider.h"
#import "RequestManagerFactory.h"

@implementation BaseProvider

- (id<RequestManager>)requestManager {
    if (!_requestManager) {
        _requestManager = [RequestManagerFactory httpRequestManager];
    }
    return _requestManager;
}

@end
