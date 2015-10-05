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
        ResultSearchViewController *resultSearchViewController = [[ResultSearchViewController alloc] initWithSearchQuery:self.searchTextField.text];
        [self.navigationController pushViewController:resultSearchViewController animated:YES];
    } else {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"ERROR" message:@"Debes introducir una localidad" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alertController addAction:okAction];
        [self presentViewController:alertController animated:YES completion:nil];
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
