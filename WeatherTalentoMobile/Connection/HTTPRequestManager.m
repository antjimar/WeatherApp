//
//  HTTPRequestManager.m
//  WeatherTalentoMobile
//
//  Created by ANTONIO JIMÉNEZ MARTÍNEZ on 11/08/15.
//  Copyright (c) 2015 TalentoMobile. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "HTTPRequestManager.h"
#import "HTTPSessionManager.h"

@interface HTTPRequestManager ()
@property (strong, nonatomic) HTTPSessionManager *httpSessionManager;
@end

@implementation HTTPRequestManager

#pragma mark - HTTP Methods
- (void)GET:(NSString *)strinURL parameters:(NSDictionary *)parameters completion:(void (^)(id responseObject))successBlock error:(void (^)(id, NSError *error))errorBlock {
    [self showNetworkActivityIndicator];
    NSLog(@"Petición tipo GET con parámetros: %@", parameters);
    
    NSURL *url = [NSURL URLWithString:strinURL];
    url = [self NSURL:url byAppendingQueryParameters:parameters];
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"GET";
    
    NSURLSessionDataTask* task = [self.httpSessionManager dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSHTTPURLResponse *HTTPResponse = (NSHTTPURLResponse *)response;
        [self hideNetworkActivityIndicator];
        if (!error) {
            if (HTTPResponse.statusCode == 200) {
                if (successBlock) {
                    successBlock(data);
                }
            } else {
                if (errorBlock) {
                    NSError *errorStatusCode = [NSError errorWithDomain:@"weatherApp" code:HTTPResponse.statusCode userInfo:nil];
                    errorBlock(data, errorStatusCode);
                }
            }
        } else {
            if (error) {
                errorBlock(nil, error);
            }
        }
        NSDictionary *reponseDictionary = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
        NSLog(@"Datos de respuesta: %@", reponseDictionary);
    }];
    [task resume];
}

#pragma mark - Getters Methods
- (HTTPSessionManager *)httpSessionManager {
    if (!_httpSessionManager) {
        _httpSessionManager = [HTTPSessionManager sharedInstance];
    }
    return _httpSessionManager;
}

#pragma mark - Private Methods
- (NSURL *)NSURL:(NSURL *)URL byAppendingQueryParameters:(NSDictionary *)parameters {
    NSString* URLString = [NSString stringWithFormat:@"%@?%@", [URL absoluteString], [self stringFromQueryParameters:parameters]];
    return [NSURL URLWithString:URLString];
}
- (NSString *)stringFromQueryParameters:(NSDictionary *)queryParameters {
    NSMutableArray* parts = [NSMutableArray array];
    [queryParameters enumerateKeysAndObjectsUsingBlock:^(id key, id value, BOOL *stop) {
        NSString *part = [NSString stringWithFormat: @"%@=%@",
                          [key stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],
                          [value stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]
                          ];
        [parts addObject:part];
    }];
    return [parts componentsJoinedByString: @"&"];
}
- (void)showNetworkActivityIndicator {
    if (![[UIApplication sharedApplication] isStatusBarHidden]) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    }
}
- (void)hideNetworkActivityIndicator {
    if (![[UIApplication sharedApplication] isStatusBarHidden]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        });
    }
}

@end
