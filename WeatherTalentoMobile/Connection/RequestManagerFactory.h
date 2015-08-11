//
//  RequestManagerFactory.h
//  WeatherTalentoMobile
//
//  Created by ANTONIO JIMÉNEZ MARTÍNEZ on 11/08/15.
//  Copyright (c) 2015 TalentoMobile. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RequestManager.h"

@interface RequestManagerFactory : NSObject

+ (id<RequestManager>)httpRequestManager;

@end
