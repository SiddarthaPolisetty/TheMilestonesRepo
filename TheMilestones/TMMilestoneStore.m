//
//  TMMilestoneStore.m
//  TheMilestones
//
//  Created by Siddartha Polisetty on 5/17/16.
//  Copyright © 2016 Siddartha Polisetty. All rights reserved.
//

#import "TMMilestoneStore.h"
#import "TMMilestone.h"


@interface TMMilestoneStore ()
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@end

@implementation TMMilestoneStore
#pragma mark - initializers
+ (instancetype)sharedStore {
    static TMMilestoneStore *sharedStore = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedStore = [[self alloc] initPrivate];
    });
    return sharedStore;
}

- (instancetype)init {
    [NSException raise:@"Singleton" format:@"use [TMMilestoneStore sharedStore]"];
    return nil;
}

- (instancetype)initPrivate {
    if (self = [super init]) {
    }
    return self;
}


#pragma mark - Core Data stack

- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}

- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"TheMilestones" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"TheMilestones.sqlite"];
    
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}

#pragma mark - Application's Documents directory

- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}


#pragma mark - CDAuto CRUD

- (NSArray *)allMilestones {
    return [self allMilestonesWithPredicate:nil WithSortDescriptors:nil];
}

- (NSArray *)allMilestonesWithPredicate:(NSPredicate *)predicate WithSortDescriptors:(NSArray *)sortDescriptors {
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSString *entityName = NSStringFromClass(TMMilestone.class);
    fetchRequest.entity = [NSEntityDescription entityForName:entityName
                                      inManagedObjectContext:self.managedObjectContext];
    if (sortDescriptors) {
        fetchRequest.sortDescriptors = sortDescriptors;
    }
    if (predicate) {
        fetchRequest.predicate = predicate;
    }
    NSError *error;
    NSArray *results = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    if (error) {
        @throw [NSException exceptionWithName:@"Fetch Failed"
                                       reason:[error description]
                                     userInfo:nil];
    }
    return results;
}

- (void)removeMilestone:(TMMilestone *)milestone {
    [self.managedObjectContext deleteObject:milestone];
}
@end
