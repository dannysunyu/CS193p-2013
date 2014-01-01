//
//  PhotosByPhotograherMapViewController.h
//  Photomania
//
//  Created by 孙 昱 on 14-1-1.
//  Copyright (c) 2014年 Stanford University. All rights reserved.
//

#import "MapViewController.h"
#import "Photographer.h"

@interface PhotosByPhotograherMapViewController : MapViewController

// displays all Photos by the given photographer on the mapView

@property (nonatomic, strong) Photographer *photographer;

@end
