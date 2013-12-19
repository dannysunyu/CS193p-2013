//
//  PhotosBySpotCDTVC.m
//  CoreDataSPoT
//
//  Created by 孙 昱 on 13-12-19.
//  Copyright (c) 2013年 CS193p. All rights reserved.
//

#import "PhotosBySpotCDTVC.h"

@interface PhotosBySpotCDTVC ()

@end

@implementation PhotosBySpotCDTVC

- (void)setSpot:(Spot *)spot
{
    _spot = spot;
    self.title = spot.name;
    
}

- (void)setupFetchedResultsController
{
    
}

#pragma mark - UITableViewDataSource



@end
