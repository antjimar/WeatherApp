//
//  HTTPSessionManager.m
//  WeatherTalentoMobile
//
//  Created by ANTONIO JIMÉNEZ MARTÍNEZ on 11/08/15.
//  Copyright (c) 2015 TalentoMobile. All rights reserved.
//

#import "HTTPSessionManager.h"

@implementation HTTPSessionManager

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    static HTTPSessionManager *_sharedInstance = nil;
    dispatch_once(&onceToken, ^{
        NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
        sessionConfiguration.HTTPAdditionalHeaders = @{
                                                       @"Accept": @"application/json",
                                                       @"Accept-Charset": @"UTF-8"
                                                       };
        NSURLCache *cache = [[NSURLCache alloc] initWithMemoryCapacity:10 * 1024 * 1024     // 10MB. memory cache
                                                          diskCapacity:50 * 1024 * 1024     // 50MB. on disk cache
                                                              diskPath:nil];
        sessionConfiguration.URLCache = cache;
        sessionConfiguration.requestCachePolicy = NSURLRequestUseProtocolCachePolicy;
        
        _sharedInstance = (HTTPSessionManager *)[NSURLSession sessionWithConfiguration:sessionConfiguration delegate:nil delegateQueue:nil];
        
    });
    return _sharedInstance;
}

@end
