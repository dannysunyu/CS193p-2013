//
//  PhotographerMapViewController.h
//  Photomania
//
//  Created by 孙 昱 on 13-12-29.
//  Copyright (c) 2013年 Stanford University. All rights reserved.
//

#import "MapViewController.h"

@interface PhotographerMapViewController : MapViewController

// displays all Photographers in the managedObjectContext
//   (with more than 2 photos) on the mapView

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;

// requeries Core Data for the Photographers

- (void)reload;

@end
