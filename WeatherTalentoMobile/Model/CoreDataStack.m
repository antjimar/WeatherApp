//
//  CoreDataStack.m
//  WeatherTalentoMobile
//
//  Created by ANTONIO JIMÉNEZ MARTÍNEZ on 11/08/15.
//  Copyright (c) 2015 TalentoMobile. All rights reserved.
//

#import "CoreDataStack.h"

NSString * const managedObjectContextDidMergeChangesNotification = @"managedObjectContextDidMergeChangesNotification";

@interface CoreDataStack ()

@property (nonatomic, readwrite, strong) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, readwrite, strong) NSManagedObjectContext *writeToDiskManagedObjectContext;
@property (nonatomic, readwrite, strong) NSManagedObjectContext *writeManagedObjectContext;
@property (nonatomic, strong) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, strong) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@end

@implementation CoreDataStack

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    static CoreDataStack *sharedInstance = nil;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[CoreDataStack alloc] init];
    });
    return sharedInstance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self registerForManagedObjectContextSaveNotifications];
    }
    return self;
}
- (void)registerForManagedObjectContextSaveNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(managedObjectContextSavedChanges:) name:NSManagedObjectContextDidSaveNotification object:self.managedObjectContext];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(childManagedObjectContextSavedChanges:) name:NSManagedObjectContextDidSaveNotification object:self.writeManagedObjectContext];
}

#pragma mark - Public API Methods
- (NSManagedObjectContext *)newBackgroundQueueManagedObjectContext {
    NSManagedObjectContext *managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
    [managedObjectContext setMergePolicy:NSMergeByPropertyObjectTrumpMergePolicy];
    [managedObjectContext setParentContext:self.managedObjectContext];
    [managedObjectContext setUndoManager:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(childManagedObjectContextSavedChanges:) name:NSManagedObjectContextDidSaveNotification object:managedObjectContext];
    return managedObjectContext;
}
- (void)deleteAllObjectsForEntity:(NSEntityDescription *)entityDescription completion:(CoreDataManagerCompletionBlock)completion {
    [self.writeToDiskManagedObjectContext performBlock:^{
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
        [fetchRequest setEntity:entityDescription];
        NSError *error;
        NSArray *items = [self.writeToDiskManagedObjectContext executeFetchRequest:fetchRequest error:&error];
        NSLog(@"%@", error);
        
        for (NSManagedObject *managedObject in items) {
            [self.writeToDiskManagedObjectContext deleteObject:managedObject];
            NSLog(@"%@ object deleted", entityDescription.name);
        }
        
        [self.writeToDiskManagedObjectContext save:&error];
        if (error) {
            NSLog(@"%@", error);
        }
        
        if (completion) {
            completion(YES);
        }
    }];
}
- (void)deleteAllObjectsForEntity:(NSEntityDescription *)entityDescription {
    [self deleteAllObjectsForEntity:entityDescription completion:nil];
}

#pragma mark - Core Data Methods
- (void)managedObjectContextSavedChanges:(NSNotification *)notification {
    [self.writeToDiskManagedObjectContext performBlock:^{
        if ([self.writeToDiskManagedObjectContext hasChanges]) {
            NSError *error;
            [self.writeToDiskManagedObjectContext save:&error];
            if (error) {
                NSLog(@"%@", error);
            }
        }
    }];
}
- (void)childManagedObjectContextSavedChanges:(NSNotification *)notification {
    [self.managedObjectContext performBlock:^{
        if ([self.managedObjectContext hasChanges]) {
            NSError *error;
            [self.managedObjectContext save:&error];
            if (error) {
                NSLog(@"%@", error);
            }
        }
    }];
}
- (void)saveMainThreadContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil && [managedObjectContext hasChanges]) {
        [managedObjectContext performBlock:^{
            NSError *error;
            [managedObjectContext save:&error];
            if (error) {
                NSLog(@"%@", error);
            }
        }];
    }
}
- (void)cleanAllLocalStorage {
    [self.writeToDiskManagedObjectContext performBlockAndWait:^{
        for (NSEntityDescription *entityDescription in self.managedObjectModel.entities) {
            [self deleteAllObjectsForEntity:entityDescription];
        }
    }];
}

#pragma mark - Core Data Stack Methods
- (NSManagedObjectContext *)writeToDiskManagedObjectContext {
    if (!_writeToDiskManagedObjectContext) {
        _writeToDiskManagedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
        [_writeToDiskManagedObjectContext setPersistentStoreCoordinator:self.persistentStoreCoordinator];
        [_writeToDiskManagedObjectContext setMergePolicy:NSMergeByPropertyObjectTrumpMergePolicy];
        [_writeToDiskManagedObjectContext setUndoManager:nil];
    }
    return _writeToDiskManagedObjectContext;
}
- (NSManagedObjectContext *)managedObjectContext {
    if (!_managedObjectContext) {
        _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
        [_managedObjectContext setMergePolicy:NSMergeByPropertyObjectTrumpMergePolicy];
        [_managedObjectContext setParentContext:self.writeToDiskManagedObjectContext];
        [_managedObjectContext setUndoManager:nil];
    }
    return _managedObjectContext;
}
- (NSManagedObjectContext *)writeManagedObjectContext {
    if (!_writeManagedObjectContext) {
        _writeManagedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
        [_writeManagedObjectContext setMergePolicy:NSMergeByPropertyObjectTrumpMergePolicy];
        [_writeManagedObjectContext setParentContext:self.managedObjectContext];
        [_writeManagedObjectContext setUndoManager:nil];
    }
    return _writeManagedObjectContext;
}
- (NSManagedObjectModel *)managedObjectModel {
    if (!_managedObjectModel) {
        NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"Model" withExtension:@"momd"];
        _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    }
    return _managedObjectModel;
}
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    if (!_persistentStoreCoordinator) {
        NSString *dataBaseFileName = [NSString stringWithFormat:@"%@.sqlite", @"Model"];
        NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:dataBaseFileName];
        NSLog(@"%@", [[storeURL description] stringByReplacingOccurrencesOfString:@"%20" withString:@" "]);
        
        _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
        NSDictionary *options = @{NSMigratePersistentStoresAutomaticallyOption:[NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption: [NSNumber numberWithBool:YES]};
        
        NSError *error;
        [_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:options error:&error];
        if (error) {
            NSLog(@"%@", error);
            [[NSFileManager defaultManager] removeItemAtURL:storeURL error:&error];
            NSLog(@"%@", error);
            _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
            [_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:options error:&error];
            if (error) {
                NSLog(@"%@", error);
            }
        }
    }
    return _persistentStoreCoordinator;
}

#pragma mark - Private Methods
- (NSURL *)applicationDocumentsDirectory {
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

#pragma mark - Memory Management Methods
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end
