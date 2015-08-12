//
//  SearchViewController.m
//  WeatherTalentoMobile
//
//  Created by ANTONIO JIMÉNEZ MARTÍNEZ on 12/08/15.
//  Copyright (c) 2015 TalentoMobile. All rights reserved.
//

#import "SearchViewController.h"
#import "ResultSearchViewController.h"

@interface SearchViewController ()
@property (weak, nonatomic) IBOutlet UITextField *searchTextField;
@end

@implementation SearchViewController

- (instancetype)init {
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        self.title = @"Buscar Localidades";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark - Actions Methods
- (IBAction)searchLocations:(UIButton *)sender {
    if ([self shouldSearch]) {
        // Search
        ResultSearchViewController *resultSearchViewController = [[ResultSearchViewController alloc] initWithSearchQuery:self.searchTextField.text];
        [self.navigationController pushViewController:resultSearchViewController animated:YES];
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"ERROR" message:@"Debes introducir una localidad" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
}

#pragma mark - Utils Methods
- (BOOL)shouldSearch {
    BOOL result = NO;
    self.searchTextField.text = [self.searchTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if (self.searchTextField.text && ![self.searchTextField.text isEqualToString:@""]) {
        result = YES;
    }
    return result;
}

@end
