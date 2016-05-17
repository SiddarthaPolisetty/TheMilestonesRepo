//
//  TMHomeViewController.m
//  TheMilestones
//
//  Created by Siddartha Polisetty on 5/17/16.
//  Copyright © 2016 Siddartha Polisetty. All rights reserved.
//

#import "TMHomeViewController.h"

@interface TMHomeViewController ()

@end

@implementation TMHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //Placeholder for navigation bar branding
    self.navigationItem.title = @"TheMilestones";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addMilestone)];
}

- (void)addMilestone {
    //Placeholder for adding milestone
}
@end
