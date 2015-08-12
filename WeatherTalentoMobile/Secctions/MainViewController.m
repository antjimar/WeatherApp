//
//  MainViewController.m
//  WeatherTalentoMobile
//
//  Created by ANTONIO JIMÉNEZ MARTÍNEZ on 12/08/15.
//  Copyright (c) 2015 TalentoMobile. All rights reserved.
//

#import "MainViewController.h"
#import "CoreDataStack.h"
#import "LocationSelectedEntity.h"
#import "TemperatureDetailViewController.h"
#import "SearchViewController.h"

@interface MainViewController ()<UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSFetchedResultsController *fetchResultController;
@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibName bundle:(NSBundle *)bundle {
    self = [super initWithNibName:nibName bundle:bundle];
    if (self) {
        self.title = @"Últimas Búsquedas";
        NSError *fetchError;
        [self.fetchResultController performFetch:&fetchError];
        if (fetchError) {
            NSLog(@"%@", fetchError);
        }
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureTableView];
    [self configureNavigationBar];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tableView deselectRowAtIndexPath:self.tableView.indexPathForSelectedRow animated:YES];
}

#pragma mark - UITableViewDataSource Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return (NSInteger)[[self.fetchResultController.sections objectAtIndex:0] numberOfObjects];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"mainCell" forIndexPath:indexPath];
    return [self configureCell:cell forRowAtIndexPath:indexPath];
}

#pragma mark - UITableViewDelegate Methods
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    LocationSelectedEntity *locationSelectedEntity = [self locationSelectedEnityAtIndexPath:indexPath];
    TemperatureDetailViewController *temperatureDetailViewController = [[TemperatureDetailViewController alloc] initWithModel:locationSelectedEntity];
    [self.navigationController pushViewController:temperatureDetailViewController animated:YES];
}

#pragma mark - NSFetchedResultsControllerDelegate
- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView beginUpdates];
}
- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath {
    
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationTop];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeUpdate:
            [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeMove:
            [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [self.tableView insertRowsAtIndexPaths:@[newIndexPath]withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}
- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView endUpdates];
}

#pragma mark - Configure View Controller Methods
- (void)configureTableView {
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}
- (void)configureNavigationBar {
    UIBarButtonItem *searchButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(showSearchViewController)];
    [self.navigationItem setRightBarButtonItem:searchButton];
}

#pragma mark - Actions Methods
- (void)showSearchViewController {
    SearchViewController *searchViewController = [[SearchViewController alloc] init];
    [self.navigationController pushViewController:searchViewController animated:YES];
}

#pragma mark - Getters
- (NSFetchedResultsController *)fetchResultController {
    if (!_fetchResultController) {
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:NSStringFromClass([LocationSelectedEntity class])];
        NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"locationSelectedDate" ascending:YES];
        fetchRequest.sortDescriptors = @[sortDescriptor];
        _fetchResultController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:[CoreDataStack sharedInstance].managedObjectContext sectionNameKeyPath:nil cacheName:nil];
        _fetchResultController.delegate = self;
    }
    return _fetchResultController;
}

#pragma mark - Private Methods
- (UITableViewCell *)configureCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    LocationSelectedEntity *locationSelectedEntity = [self locationSelectedEnityAtIndexPath:indexPath];
    cell.textLabel.text = locationSelectedEntity.locationEntityName;
    return cell;
}
- (LocationSelectedEntity *)locationSelectedEnityAtIndexPath:(NSIndexPath *)indexPath {
    LocationSelectedEntity *locationSelectedEntity = [self.fetchResultController objectAtIndexPath:indexPath];
    return locationSelectedEntity;
}

@end
