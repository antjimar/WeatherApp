//
//  TemperatureDetailViewController.h
//  WeatherTalentoMobile
//
//  Created by ANTONIO JIMÉNEZ MARTÍNEZ on 12/08/15.
//  Copyright (c) 2015 TalentoMobile. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LocationSelectedEntity;

@interface TemperatureDetailViewController : UIViewController

- (instancetype)initWithModel:(LocationSelectedEntity *)locationSelectedEntity;

@end
