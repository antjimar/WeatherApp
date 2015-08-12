//
//  AppDelegate.m
//  WeatherTalentoMobile
//
//  Created by ANTONIO JIMÉNEZ MARTÍNEZ on 11/08/15.
//  Copyright (c) 2015 TalentoMobile. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    
    
    
    
    
    
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
//    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
//    [self customiseAppeareance];
//    self.coreDataStack = [[CoreDataStack alloc] initWithModelName:kModelName];
//    
//    UICollectionViewFlowLayout *layout = [self setupLayout];
//    NSFetchedResultsController *results = [self setupNSFetchResultsController];
//    
//    MainPictureViewController *mainViewController = [[MainPictureViewController alloc] initWithFetchedResultsController:results
//                                                                                                                 layout:layout
//                                                                                                           andIndicator:nil];
//    mainViewController.coreDataStack = self.coreDataStack;
//    UINavigationController *navigatinoVC = [[UINavigationController alloc] initWithRootViewController:mainViewController];
//    [self.window setRootViewController:navigatinoVC];
//    self.window.backgroundColor = [UIColor whiteColor];
//    [self.window makeKeyAndVisible];
    
    
    
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
}

- (void)applicationWillTerminate:(UIApplication *)application {
}

@end
