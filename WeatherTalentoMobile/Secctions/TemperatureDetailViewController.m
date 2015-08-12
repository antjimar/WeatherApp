//
//  TemperatureDetailViewController.m
//  WeatherTalentoMobile
//
//  Created by ANTONIO JIMÉNEZ MARTÍNEZ on 12/08/15.
//  Copyright (c) 2015 TalentoMobile. All rights reserved.
//

#import "TemperatureDetailViewController.h"
#import "LocationSelectedEntity.h"

@interface TemperatureDetailViewController ()
@property (strong, nonatomic) LocationSelectedEntity *locationSelectedEntity;
@end

@implementation TemperatureDetailViewController

- (instancetype)initWithModel:(LocationSelectedEntity *)locationSelectedEntity {
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        _locationSelectedEntity = locationSelectedEntity;
        self.title = [NSString stringWithFormat:@"Temperatura de: %@", locationSelectedEntity.locationEntityName];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

@end
