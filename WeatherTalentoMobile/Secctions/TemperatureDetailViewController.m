//
//  TemperatureDetailViewController.m
//  WeatherTalentoMobile
//
//  Created by ANTONIO JIMÉNEZ MARTÍNEZ on 12/08/15.
//  Copyright (c) 2015 TalentoMobile. All rights reserved.
//

#import "TemperatureDetailViewController.h"
#import "LocationSelectedEntity.h"
#import "AverageTemperatureInteractor.h"
@import MapKit;

@interface TemperatureDetailViewController ()<UIAlertViewDelegate>

@property (strong, nonatomic) LocationSelectedEntity *locationSelectedEntity;
@property (strong, nonatomic) AverageTemperatureInteractor *averageTemperatureInteractor;
@property (weak, nonatomic) IBOutlet UILabel *locationNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *temperatureLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lineWithConstraint;
@property (weak, nonatomic) IBOutlet MKMapView *locationMap;

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
    [self configureView];
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self loadData];
}

#pragma mark - Utils Methods
- (void)loadData {
    __weak typeof(self) weakSelf = self;
    [self.averageTemperatureInteractor averageTemperaturesWithLocationEntity:self.locationSelectedEntity withCompletion:^(NSNumber *averageTemperature, NSError *error) {
        __strong typeof(weakSelf) self = weakSelf;
        if (error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [[[UIAlertView alloc] initWithTitle:@"ERROR" message:@"Error del servidor" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
            });
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                self.temperatureLabel.text = [NSString stringWithFormat:@"%.2f ºC", [averageTemperature floatValue]];
                [UIView animateWithDuration:2.0f delay:0.f options:UIViewAnimationOptionCurveEaseInOut|UIViewAnimationOptionBeginFromCurrentState animations:^{
                    self.lineWithConstraint.constant = ([averageTemperature floatValue] * 2.5f) + (20.0f * 2.5f);
                    [self.view layoutIfNeeded];
                } completion:nil];
                [self setUpMap];
            });
        }
    }];
}
- (void)setUpMap {
    if (self.locationSelectedEntity.locationEntityLatitude == nil || self.locationSelectedEntity.locationEntityLongitude == nil) {
        [self.locationMap setHidden:YES];
        
    } else {
        [self.locationMap setHidden:NO];
        CLLocationCoordinate2D locationSearch = CLLocationCoordinate2DMake([self.locationSelectedEntity.locationEntityLatitude doubleValue],
                                                                            [self.locationSelectedEntity.locationEntityLongitude doubleValue]);
        MKCoordinateSpan coordinateSpan = MKCoordinateSpanMake(1, 1);
        MKCoordinateRegion coordinateRegion = MKCoordinateRegionMake(locationSearch, coordinateSpan);
        [self.locationMap setRegion:coordinateRegion animated:YES];
        MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
        [annotation setCoordinate:locationSearch];
        
        // Get Address
        CLLocation *location = [[CLLocation alloc] initWithLatitude:[self.locationSelectedEntity.locationEntityLatitude doubleValue]
                                                          longitude:[self.locationSelectedEntity.locationEntityLongitude doubleValue]];
        CLGeocoder *geocoder = [[CLGeocoder alloc] init];
        [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
            if (placemarks.count) {
                NSDictionary *dictionary = [[placemarks objectAtIndex:0] addressDictionary];
                [annotation setTitle:dictionary[@"City"]];
                [annotation setSubtitle:dictionary[@"Country"]];
            } else {
                [annotation setTitle:self.locationSelectedEntity.locationEntityName];
            }
            [self.locationMap addAnnotation:annotation];
        }];
    }
}


- (void)configureView {
    self.locationNameLabel.text = [self.locationSelectedEntity.locationEntityName uppercaseString];
    self.temperatureLabel.text = @"...";
    self.lineWithConstraint.constant = 0.0f;
}

#pragma mark - Actions Methods
- (IBAction)closeTemperatureDetail:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:^{
    }];
}

#pragma mark - UIAlertViewDelegate Methods
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    [self dismissViewControllerAnimated:YES completion:^{
    }];
}

#pragma mark - Getters Methods
- (AverageTemperatureInteractor *)averageTemperatureInteractor {
    if (!_averageTemperatureInteractor) {
        _averageTemperatureInteractor = [[AverageTemperatureInteractor alloc] init];
    }
    return _averageTemperatureInteractor;
}

@end
