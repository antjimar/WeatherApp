//
//  CoreDataStack.h
//  WeatherTalentoMobile
//
//  Created by ANTONIO JIMÉNEZ MARTÍNEZ on 11/08/15.
//  Copyright (c) 2015 TalentoMobile. All rights reserved.
//
#import <CoreData/CoreData.h>
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

UIKIT_EXTERN NSString * const managedObjectContextDidMergeChangesNotification;

typedef void(^CoreDataManagerCompletionBlock)(BOOL finished);

@interface CoreDataStack : NSObject

@property (nonatomic, readonly, strong) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, readonly, strong) NSManagedObjectContext *writeManagedObjectContext;

+ (instancetype)sharedInstance;
- (void)cleanAllLocalStorage;
- (void)deleteAllObjectsForEntity:(NSEntityDescription *)entityDescription completion:(CoreDataManagerCompletionBlock)completion;
- (void)deleteAllObjectsForEntity:(NSEntityDescription *)entityDescription;
- (NSManagedObjectContext *)newBackgroundQueueManagedObjectContext;

@end
