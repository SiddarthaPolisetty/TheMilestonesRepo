//
//  TMMilestone+CoreDataProperties.h
//  TheMilestones
//
//  Created by Siddartha Polisetty on 5/17/16.
//  Copyright © 2016 Siddartha Polisetty. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "TMMilestone.h"

NS_ASSUME_NONNULL_BEGIN

@interface TMMilestone (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *mileStoneName;
@property (nullable, nonatomic, retain) NSString *mileStoneType;
@property (nullable, nonatomic, retain) NSDate *mileStoneDate;
@property (nullable, nonatomic, retain) NSData *mileStoneImage;
@property (nullable, nonatomic, retain) NSString *mileStoneNotes;

@end

NS_ASSUME_NONNULL_END
