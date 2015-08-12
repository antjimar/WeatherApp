//
//  ResultSearchViewController.m
//  WeatherTalentoMobile
//
//  Created by ANTONIO JIMÉNEZ MARTÍNEZ on 12/08/15.
//  Copyright (c) 2015 TalentoMobile. All rights reserved.
//

#import "ResultSearchViewController.h"
#import "SearchLocationInteractor.h"
#import "SaveLocationInteractor.h"
#import "LocationEntity.h"
#import "TemperatureDetailViewController.h"

static NSString * const kCellIdentifier = @"resultCell";

@interface ResultSearchViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, copy) NSString *searchQuery;
@property (nonatomic, strong) SearchLocationInteractor *searchLocationInteractor;
@property (nonatomic, strong) SaveLocationInteractor *saveLocationInteractor;
@property (nonatomic, strong) NSArray *resultLocations;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@end

@implementation ResultSearchViewController

- (instancetype)initWithSearchQuery:(NSString *)searchQuery {
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        _searchQuery = searchQuery;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureTableView];
    [self loadData];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tableView deselectRowAtIndexPath:self.tableView.indexPathForSelectedRow animated:YES];
}

#pragma mark UITableViewDataSource -  Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return (NSInteger)[self.resultLocations count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier forIndexPath:indexPath];
    return [self configureCell:cell forRowAtIndexPath:indexPath];
}

#pragma mark - UITableViewDelegate Methods
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    LocationEntity *locationEntity = [self.resultLocations objectAtIndex:indexPath.row];
    // Guardamos en core data la localización selecionada
    __weak typeof(self) weakSelf = self;
    [self.saveLocationInteractor saveLocationSelectedWithLocationEntity:locationEntity withCompletion:^(LocationSelectedEntity *locationSelectedEntity, NSError *error) {
        __strong typeof(weakSelf) self = weakSelf;
        if (error) {
            NSLog(@"%@", error);
        } else {
            [self navigateToTemperatureDetailWithLocationSelected:locationSelectedEntity];
        }
    }];
}

- (void)navigateToTemperatureDetailWithLocationSelected:(LocationSelectedEntity *)locationSelectedEntity {
    TemperatureDetailViewController *temperatureDetailViewController = [[TemperatureDetailViewController alloc] initWithModel:locationSelectedEntity];
    [self presentViewController:temperatureDetailViewController animated:YES completion:^{
    }];
}

#pragma mark - Configure View Controller Methods
- (void)configureTableView {
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kCellIdentifier];
    [self.activityIndicator startAnimating];
}

#pragma mark - Private Methods
- (void)loadData {
    __weak typeof(self) weakSelf = self;
    [self.searchLocationInteractor searchLocationByName:self.searchQuery withCompletion:^(NSArray *array, NSError *error) {
        __strong typeof(weakSelf) self = weakSelf;
        self.resultLocations = array;
        [self.tableView reloadData];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.activityIndicator startAnimating];
            [self.activityIndicator setHidden:YES];
        });
    }];
}
- (UITableViewCell *)configureCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    LocationEntity *locationEntity = [self locationEnityAtIndexPath:indexPath];
    cell.textLabel.text = locationEntity.locationEntityName;
    return cell;
}
- (LocationEntity *)locationEnityAtIndexPath:(NSIndexPath *)indexPath {
    LocationEntity *locationEntity = [self.resultLocations objectAtIndex:indexPath.row];
    return locationEntity;
}

#pragma mark - Getters Methods
- (SearchLocationInteractor *)searchLocationInteractor {
    if (!_searchLocationInteractor) {
        _searchLocationInteractor = [[SearchLocationInteractor alloc] init];
    }
    return _searchLocationInteractor;
}
- (SaveLocationInteractor *)saveLocationInteractor {
    if (!_saveLocationInteractor) {
        _saveLocationInteractor = [[SaveLocationInteractor alloc] init];
    }
    return _saveLocationInteractor;
}

@end
