//
//  RequestManager.h
//  WeatherTalentoMobile
//
//  Created by ANTONIO JIMÉNEZ MARTÍNEZ on 11/08/15.
//  Copyright (c) 2015 TalentoMobile. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol RequestManager <NSObject>

- (void)GET:(NSString *)strinURL
 parameters:(NSDictionary *)parameters
 completion:(void(^)(id responseObject))successBlock
      error:(void(^)(id responseObject, NSError *error))errorBlock;

@end
