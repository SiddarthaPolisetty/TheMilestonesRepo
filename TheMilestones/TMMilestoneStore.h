//
//  TMMilestoneStore.h
//  TheMilestones
//
//  Created by Siddartha Polisetty on 5/17/16.
//  Copyright © 2016 Siddartha Polisetty. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
@class TMMilestone;

@interface TMMilestoneStore : NSObject

#pragma mark - Initializer
+ (instancetype)sharedStore;

#pragma mark - core data helpers
- (NSManagedObjectContext *)managedObjectContext;

#pragma mark - CRUD helpers
- (NSArray *)allMilestones;
- (NSArray *)allMilestonesWithPredicate:(NSPredicate *)predicate WithSortDescriptors:(NSArray *)sortDescriptors;
- (void)removeMilestone:(TMMilestone *)milestone;
@end
