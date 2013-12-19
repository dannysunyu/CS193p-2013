//
//  SpotCDTVC.h
//  CoreDataSPoT
//
//  Created by 孙 昱 on 13-12-19.
//  Copyright (c) 2013年 CS193p. All rights reserved.
//
//  Can do "setSpot:" segue and will call said method in destination VC.

#import "CoreDataTableViewController.h"

@interface SpotCDTVC : CoreDataTableViewController

// The Model for this class
// Essentially specifies the database to look in to find all Spots to display in this table
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;

@end
