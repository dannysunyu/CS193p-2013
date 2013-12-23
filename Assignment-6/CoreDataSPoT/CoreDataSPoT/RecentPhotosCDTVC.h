//
//  RecentPhotosCDTVC.h
//  CoreDataSPoT
//
//  Created by 孙 昱 on 13-12-19.
//  Copyright (c) 2013年 CS193p. All rights reserved.
//

#import "CoreDataTableViewController.h"

@interface RecentPhotosCDTVC : CoreDataTableViewController

// The Model for this class
// Essentially specifies the database to look in to find all recent photos to display in this table
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;

@end
